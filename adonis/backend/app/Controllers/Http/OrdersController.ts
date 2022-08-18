import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { CreateOrderValidator, DestroyOrderValidator, ListOrdersValidator, ShowOrderValidator, UpdateOrderValidator } from 'App/Validators/OrderValidator'
import File, { Image } from 'App/Models/File'
import { ModelObject } from '@ioc:Adonis/Lucid/Orm';
import Order from 'App/Models/Order';
import OrderItemsController from './OrderItemsController';

export default class OrdersController {
  /**
    * returns the user's orders as pangination list
    * @param {HttpContextContract}
    * @returns {Promise<{meta: any;data: ModelObject[];}>}
    * @memberof OrdersController
    * @example
    * curl -X GET -H "Content-Type: application/json" -d '{"page": 1}' http://localhost:3333/api/v1/orders
    */
  public async index({ request, bouncer }: HttpContextContract): Promise<{
    meta: any;
    data: ModelObject[];
  }> {
    const payload = await request.validate(ListOrdersValidator)
    await bouncer.with('OrderPolicy').authorize('viewList', payload)
    var ordersQuery = Order.query()
    var page = 1
    var limit = 12

    if (payload.search) {
      for (let i = 0; i < payload.search_in!.length; i++) {
        const element = payload.search_in![i];
        if (i == 0) {
          ordersQuery = ordersQuery.where(element, 'like', `%${payload.search}%`)
        } else {
          ordersQuery = ordersQuery.orWhere(element, 'like', `%${payload.search}%`)
        }
      }
    }
    if (payload.sort) {
      ordersQuery = ordersQuery.orderBy(payload.sort, payload.order)
    }
    if (payload.load) {
      for (const load of payload.load) {
        ordersQuery = ordersQuery.preload(load)
      }
    }
    if (payload.where) {
      for (const key in payload.where) {
        ordersQuery = ordersQuery.where(key, payload.where[key])
      }
    }
    page = payload.page || page
    limit = payload.limit || limit

    return (await ordersQuery.paginate(page, Math.min(limit, 24))).toJSON()
  }

  /**
   * creates a new order for the user
   * @param {HttpContextContract}
   * @returns {Promise<{ order: ModelObject; photo: Image | null; }>}
   * @memberof OrdersController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Order", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/orders
   */
  public async store(ctx : HttpContextContract) {

    await ctx.bouncer.with('OrderPolicy').authorize('create', null)
    const payload = await ctx.request.validate(CreateOrderValidator)
    const order = await Order.create({
      addressId: payload.address_id,
      customerProfileId: payload.customer_profile_id,
    })
    // if payload has order_items, add them to the order
    if (payload.items) {
      var orderItemsController = new OrderItemsController();
      await orderItemsController.store(ctx);
    }
    return {
      order: order.toJSON(),
    }
  }

  /**
   * returns the order info
   * @param {HttpContextContract}
   * @returns {Promise<Order>}
   * @memberof OrdersController
   * @example
   * curl -X GET -H "Content-Type: application/json" http://localhost:3333/api/v1/orders/1
   */
  public async show({ auth, request, bouncer }: HttpContextContract): Promise<any> {
    const payload = await request.validate(ShowOrderValidator)
    var order = (await Order.find(payload.params.id))!
    await bouncer.with('OrderPolicy').authorize('view', order)
    if (payload.load) {
      for (const load of payload.load) {
        await order.load(load)
      }
    }
    return {order:order.toJSON()}
  }

  /**
   * updates the order info
   * @param {HttpContextContract}
   * @returns {Promise<Order>}
   * @memberof OrdersController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Order", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/orders/1
   */
  public async update({ request, bouncer }: HttpContextContract): Promise<any> {
    // validate also params.id
    const payload = await request.validate(UpdateOrderValidator)
    const order = (await Order.find(payload.params.id))!
    await bouncer.with('OrderPolicy').authorize('update', order)
    order.status = payload.status ?? order.status
    order.addressId = payload.address_id ?? order.addressId
    order.customerProfileId = payload.customer_profile_id ?? order.customerProfileId
    order.closedAt = payload.closed_at ?? order.closedAt
    await order.save()

    return {
      order: order.toJSON(),
    }
  }

  /**
   * deletes the order
   * @param {HttpContextContract}
   * @returns {Promise<void>}
   * @memberof OrdersController
   * @example
   * curl -X DELETE -H "Content-Type: application/json" http://localhost:3333/api/v1/orders/{orderId}
   */
  public async destroy({ request, bouncer }: HttpContextContract): Promise<void> {
    const payload = await request.validate(DestroyOrderValidator)
    const order = (await Order.find(payload.params.id))!
    await bouncer.with('OrderPolicy').authorize('delete', order)
    return await order.delete()
  }


}

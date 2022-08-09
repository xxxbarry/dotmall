import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { CreateOrderItemValidator, DestroyOrderItemValidator, ListOrderItemsValidator, ShowOrderItemValidator, UpdateOrderItemValidator } from 'App/Validators/OrderItemValidator'
import File, { Image } from 'App/Models/File'
import { ModelObject } from '@ioc:Adonis/Lucid/Orm';
import OrderItem from 'App/Models/OrderItem';

export default class OrderItemsController {
  /**
    * returns the user's orderItems as pangination list
    * @param {HttpContextContract}
    * @returns {Promise<{meta: any;data: ModelObject[];}>}
    * @memberof OrderItemsController
    * @example
    * curl -X GET -H "Content-Type: application/json" -d '{"page": 1}' http://localhost:3333/api/v1/orderItems
    */
  public async index({ request, bouncer }: HttpContextContract): Promise<{
    meta: any;
    data: ModelObject[];
  }> {
    const payload = await request.validate(ListOrderItemsValidator)
    await bouncer.with('OrderItemPolicy').authorize('viewList', payload)
    var orderItemsQuery = OrderItem.query()
    var page = 1
    var limit = 24

    if (payload.search) {
      for (let i = 0; i < payload.search_in!.length; i++) {
        const element = payload.search_in![i];
        if (i == 0) {
          orderItemsQuery = orderItemsQuery.where(element, 'like', `%${payload.search}%`)
        } else {
          orderItemsQuery = orderItemsQuery.orWhere(element, 'like', `%${payload.search}%`)
        }
      }
    }
    if (payload.sort) {
      orderItemsQuery = orderItemsQuery.orderBy(payload.sort, payload.order)
    }
    if (payload.load) {
      for (const load of payload.load) {
        orderItemsQuery = orderItemsQuery.preload(load)
      }
    }
    if (payload.where) {
      for (const key in payload.where) {
        orderItemsQuery = orderItemsQuery.where(key, payload.where[key])
      }
    }
    page = payload.page || page
    limit = payload.limit || limit

    return (await orderItemsQuery.paginate(page, Math.min(limit, 24))).toJSON()
  }

  /**
   * creates a new orderItem for the user
   * @param {HttpContextContract}
   * @returns {Promise<{ orderItem: ModelObject; photo: Image | null; }>}
   * @memberof OrderItemsController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My OrderItem", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/orderItems
   */
  public async store({ request, bouncer }: HttpContextContract) {

    await bouncer.with('OrderItemPolicy').authorize('create', null)
    const payload = await request.validate(CreateOrderItemValidator)
    const orderItem = await OrderItem.create({
      quantity: payload.quantity,
      price: payload.price,
      orderId: payload.order_id,
      productId: payload.product_id,
    })
    return {
      orderItem: orderItem.toJSON(),
    }
  }

  /**
   * returns the orderItem info
   * @param {HttpContextContract}
   * @returns {Promise<OrderItem>}
   * @memberof OrderItemsController
   * @example
   * curl -X GET -H "Content-Type: application/json" http://localhost:3333/api/v1/orderItems/1
   */
  public async show({ auth, request, bouncer }: HttpContextContract): Promise<any> {
    const payload = await request.validate(ShowOrderItemValidator)
    var orderItem = (await OrderItem.find(payload.params.id))!
    await bouncer.with('OrderItemPolicy').authorize('view', orderItem)
    if (payload.load) {
      for (const load of payload.load) {
        await orderItem.load(load)
      }
    }
    return {orderItem:orderItem.toJSON()}
  }

  /**
   * updates the orderItem info
   * @param {HttpContextContract}
   * @returns {Promise<OrderItem>}
   * @memberof OrderItemsController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My OrderItem", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/orderItems/1
   */
  public async update({ request, bouncer }: HttpContextContract): Promise<any> {
    // validate also params.id
    const payload = await request.validate(UpdateOrderItemValidator)
    const orderItem = (await OrderItem.find(payload.params.id))!
    await bouncer.with('OrderItemPolicy').authorize('update', orderItem)
    orderItem.quantity = payload.quantity ?? orderItem.quantity
    orderItem.price = payload.price ?? orderItem.price
    orderItem.orderId = payload.order_id ?? orderItem.orderId
    orderItem.productId = payload.product_id ?? orderItem.productId
    await orderItem.save()
    return {
      orderItem: orderItem.toJSON(),
    }
  }

  /**
   * deletes the orderItem
   * @param {HttpContextContract}
   * @returns {Promise<void>}
   * @memberof OrderItemsController
   * @example
   * curl -X DELETE -H "Content-Type: application/json" http://localhost:3333/api/v1/orderItems/{orderItemId}
   */
  public async destroy({ request, bouncer }: HttpContextContract): Promise<void> {
    const payload = await request.validate(DestroyOrderItemValidator)
    const orderItem = (await OrderItem.find(payload.params.id))!
    await bouncer.with('OrderItemPolicy').authorize('delete', orderItem)
    return await orderItem.delete()
  }


}

import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { ModelObject } from '@ioc:Adonis/Lucid/Orm';
import CustomerProfile from 'App/Models/accounts/profiles/CustomerProfile';
import { CreateCustomerProfileValidator, DestroyCustomerProfileValidator, ListCustomerProfilesValidator, ShowCustomerProfileValidator, UpdateCustomerProfileValidator } from 'App/Validators/CustomerProfileValidator';

export default class CustomerProfilesController {
    /**
      * returns the user's account customers as pangination list
      * @param {HttpContextContract}
      * @returns {Promise<{meta: any;data: ModelObject[];}>}
      * @memberof CustomerProfilesController
      * @example
      * curl -X GET -H "Content-Type: application/json" -d '{"page": 1}' http://localhost:3333/api/v1/customers
      */
    public async index({ auth, request, bouncer }: HttpContextContract): Promise<{
        meta: any;
        data: ModelObject[];
    }> {
        const payload = await request.validate(ListCustomerProfilesValidator)
        await bouncer.with('CustomerPolicy').authorize('viewList', payload)
        var customersQuery = CustomerProfile.query()
        var page = 1
        var limit = 24


        if (payload.search) {
          for (let i = 0; i < payload.search_by!.length; i++) {
            const element = payload.search_by![i];
            if (i == 0) {
              customersQuery = customersQuery.where(element, 'like', `%${payload.search}%`)
            } else {
              customersQuery = customersQuery.orWhere(element, 'like', `%${payload.search}%`)
            }
          }
        }
        if (payload.sort) {
            customersQuery = customersQuery.orderBy(payload.sort, payload.order)
        }
        if (payload.load) {
            for (const load of payload.load) {
                customersQuery = customersQuery.preload(load)
            }
        }
        if (payload.where) {
            for (const key in payload.where) {
                customersQuery = customersQuery.where(key, payload.where[key])
            }
        }
        page = payload.page || page
        limit = payload.limit || limit

        return (await customersQuery.paginate(page, Math.min(limit, 24))).toJSON()
    }

    /**
     * creates a new customer for the user
     * @param {HttpContextContract}
     * @returns {Promise<{ customer_profile: ModelObject; }>}
     * @memberof CustomerProfilesController
     * @example
     */
    public async store({ request,  bouncer }: HttpContextContract): Promise<{ customer_profile: ModelObject; }> {

        const payload = await request.validate(CreateCustomerProfileValidator)
        await bouncer.with('CustomerPolicy').authorize('create', payload.account_id)
        const customer = await CustomerProfile.create({
            accountId: payload.account_id,
        })
        return {
            customer_profile: customer.toJSON(),
        }
    }

    /**
     * returns the customer info
     * @param {HttpContextContract}
     * @returns {Promise<Customer>}
     * @memberof CustomerProfilesController
     * @example
     * curl -X GET -H "Content-Type: application/json" http://localhost:3333/api/v1/customers/1
     */
    public async show({ auth, request, bouncer }: HttpContextContract): Promise<any> {
        const payload = await request.validate(ShowCustomerProfileValidator)
        var customer = await CustomerProfile.query().where('id', payload.params.id).first()
        await bouncer.with('CustomerPolicy').authorize('view', customer!)
        if (payload.load) {
            for (const load of payload.load) {
                await customer!.load(load)
            }
        }
        return customer!.toJSON()
    }

    /**
     * updates the customer info
     * @param {HttpContextContract}
     * @returns {Promise<Customer>}
     * @memberof CustomerProfilesController
     * @example
     * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Customer", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/customers/1
     */
    public async update({ request, bouncer }: HttpContextContract): Promise<any> {
        // validate also params.id
        const payload = await request.validate(UpdateCustomerProfileValidator)
        const customer = (await CustomerProfile.find(payload.params.id))!
        await bouncer.with('CustomerPolicy').authorize('update', customer)
        await customer.save()
        return {
            customer_profile: customer.toJSON(),
        }
    }

    /**
     * deletes the customer
     * @param {HttpContextContract}
     * @returns {Promise<void>}
     * @memberof CustomerProfilesController
     * @example
     * curl -X DELETE -H "Content-Type: application/json" http://localhost:3333/api/v1/customers/{customerId}
     */
    public async destroy({ request, bouncer }: HttpContextContract): Promise<void> {
        const payload = await request.validate(DestroyCustomerProfileValidator)
        const customer = (await CustomerProfile.find(payload.params.id))!
        await bouncer.with('CustomerPolicy').authorize('delete', customer)
        return await customer.delete()
    }


}

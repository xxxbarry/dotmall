import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { Image } from 'App/Models/File'
import { ModelObject } from '@ioc:Adonis/Lucid/Orm';
import MerchantProfile from 'App/Models/accounts/profiles/MerchantProfile';
import { CreateMerchantProfileValidator, DestroyMerchantProfileValidator, ListMerchantProfilesValidator, ShowMerchantProfileValidator, UpdateMerchantProfileValidator } from 'App/Validators/MerchantProfileValidator';

export default class MerchantProfilesController {
    /**
      * returns the user's account merchants as pangination list
      * @param {HttpContextContract}
      * @returns {Promise<{meta: any;data: ModelObject[];}>}
      * @memberof MerchantProfilesController
      * @example
      * curl -X GET -H "Content-Type: application/json" -d '{"page": 1}' http://localhost:3333/api/v1/merchants
      */
    public async index({ auth, request, bouncer }: HttpContextContract): Promise<{
        meta: any;
        data: ModelObject[];
    }> {
        const payload = await request.validate(ListMerchantProfilesValidator)
        await bouncer.with('MerchantPolicy').authorize('viewList', payload)
        var merchantsQuery = MerchantProfile.query()
        var page = 1
        var limit = 24


        if (payload.search) {
          for (let i = 0; i < payload.search_in!.length; i++) {
            const element = payload.search_in![i];
            if (i == 0) {
              merchantsQuery = merchantsQuery.where(element, 'like', `%${payload.search}%`)
            } else {
              merchantsQuery = merchantsQuery.orWhere(element, 'like', `%${payload.search}%`)
            }
          }
        }
        if (payload.sort) {
            merchantsQuery = merchantsQuery.orderBy(payload.sort, payload.order)
        }
        if (payload.load) {
            for (const load of payload.load) {
                merchantsQuery = merchantsQuery.preload(load)
            }
        }
        if (payload.where) {
            for (const key in payload.where) {
                merchantsQuery = merchantsQuery.where(key, payload.where[key])
            }
        }
        page = payload.page || page
        limit = payload.limit || limit

        return (await merchantsQuery.paginate(page, Math.min(limit, 24))).toJSON()
    }

    /**
     * creates a new merchant for the user
     * @param {HttpContextContract}
     * @returns {Promise<{ merchant_profile: ModelObject; }>}
     * @memberof MerchantProfilesController
     * @example
     */
    public async store({ request,  bouncer }: HttpContextContract): Promise<{ merchant_profile: ModelObject; }> {

        const payload = await request.validate(CreateMerchantProfileValidator)
        await bouncer.with('MerchantPolicy').authorize('create', payload.account_id)
        const merchant = await MerchantProfile.create({
            accountId: payload.account_id,
        })
        return {
            merchant_profile: merchant.toJSON(),
        }
    }

    /**
     * returns the merchant info
     * @param {HttpContextContract}
     * @returns {Promise<Merchant>}
     * @memberof MerchantProfilesController
     * @example
     * curl -X GET -H "Content-Type: application/json" http://localhost:3333/api/v1/merchants/1
     */
    public async show({ auth, request, bouncer }: HttpContextContract): Promise<any> {
        const payload = await request.validate(ShowMerchantProfileValidator)
        var merchant = await MerchantProfile.query().where('id', payload.params.id).first()
        await bouncer.with('MerchantPolicy').authorize('view', merchant!)

        if (payload.load) {
            for (const load of payload.load) {
                await merchant!.load(load)
            }
        }
        return merchant!.toJSON()
    }

    /**
     * updates the merchant info
     * @param {HttpContextContract}
     * @returns {Promise<Merchant>}
     * @memberof MerchantProfilesController
     * @example
     * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Merchant", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/merchants/1
     */
    public async update({ request, bouncer }: HttpContextContract): Promise<any> {
        // validate also params.id
        const payload = await request.validate(UpdateMerchantProfileValidator)
        const merchant = (await MerchantProfile.find(payload.params.id))!
        await bouncer.with('MerchantPolicy').authorize('update', merchant)
        await merchant.save()
        return {
            merchant_profile: merchant.toJSON(),
        }
    }

    /**
     * deletes the merchant
     * @param {HttpContextContract}
     * @returns {Promise<void>}
     * @memberof MerchantProfilesController
     * @example
     * curl -X DELETE -H "Content-Type: application/json" http://localhost:3333/api/v1/merchants/{merchantId}
     */
    public async destroy({ request, bouncer }: HttpContextContract): Promise<void> {
        const payload = await request.validate(DestroyMerchantProfileValidator)
        const merchant = (await MerchantProfile.find(payload.params.id))!
        await bouncer.with('MerchantPolicy').authorize('delete', merchant)
        return await merchant.delete()
    }


}

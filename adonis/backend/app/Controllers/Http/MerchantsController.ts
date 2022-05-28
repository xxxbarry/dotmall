// import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'

import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import CreateMerchantProfileValidator, { DestroyMerchantProfileValidator, ListMerchantProfilesValidator, ShowMerchantProfileValidator, UpdateMerchantProfileValidator } from 'App/Validators/MerchantProfileValidator'
import { Image } from 'App/Models/File'
import MerchantProfile from 'App/Models/accounts/profiles/MerchantProfile'

export default class MerchantProfilesController {
    /*
      * returns the user's merchantProfiles as pangination list
      * @param {HttpContextContract}
      * @returns {Promise<void>}
      * @memberof MerchantProfilesController
      * @example
      * curl -X GET -H "Content-Type: application/json" -d '{"page": 1}' http://localhost:3333/api/v1/merchantProfiles
      */
    public async index({ auth, request }: HttpContextContract) {
        const payload = await request.validate(ListMerchantProfilesValidator)
        var merchantProfilesQuery = auth.user!.related("merchants").query()
        var page = 1
        var limit = 24
        // if (payload.query) {
        if (payload.search) {
            merchantProfilesQuery = merchantProfilesQuery.where('name', 'like', `%${payload.search}%`)
        }
        if (payload.sort) {
            merchantProfilesQuery = merchantProfilesQuery.orderBy(payload.sort, payload.order)
        }
        if (payload.load) {
            for (const load of payload.load) {
                merchantProfilesQuery = merchantProfilesQuery.preload(load)
            }
        }
        page = payload.page || page
        limit = payload.limit || limit

        // }
        return (await merchantProfilesQuery.paginate(page, Math.min(limit, 24))).toJSON()
    }

    /*
     * creates a new merchantProfile for the user
     * @param {HttpContextContract}
     * @returns {Promise<void>}
     * @memberof MerchantProfilesController
     * @example
     * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My MerchantProfile", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/merchantProfiles
     */
    public async store({ request, auth }: HttpContextContract) {
        const payload = await request.validate(CreateMerchantProfileValidator)
        const merchantProfile = new MerchantProfile()
        merchantProfile.accountId = payload.account_id
        await merchantProfile.save()
        return merchantProfile.toJSON()
    }

    public async show({ auth, response, params, request }: HttpContextContract) {
        const payload = await request.validate(ShowMerchantProfileValidator)
        var merchantProfile = await MerchantProfile.query().where('id', payload.params.id).where('user_id', auth.user!.id).first()
        await merchantProfile!.load('phones')
        await merchantProfile!.load('address')
        await merchantProfile!.load('emails')
        return merchantProfile!.toJSON()
    }

    public async update({ request }: HttpContextContract) {
        // validate also params.id
        const payload = await request.validate(UpdateMerchantProfileValidator)
        const merchantProfile = (await MerchantProfile.find(payload.params.id))!
        // merchantProfile.name = payload.name ?? merchantProfile.name
        // merchantProfile.description = payload.description ?? merchantProfile.description
        // await merchantProfile.save()
        return merchantProfile.toJSON()
    }

    public async destroy({ request }: HttpContextContract) {
        const payload = await request.validate(DestroyMerchantProfileValidator)
        const merchantProfile = await MerchantProfile.find(payload.params.id)
        await merchantProfile!.delete()
        return merchantProfile
    }


    static avatarPath(avatarFileName?: string): string {
        return `/uploads/merchantProfiles/${avatarFileName ?? ''}`
    }
}

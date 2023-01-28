import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { CreateStoreTranslationValidator, DestroyStoreTranslationValidator, ListStoreTranslationsValidator, ShowStoreTranslationValidator, UpdateStoreTranslationValidator } from 'App/Validators/StoreTranslationValidator'
import { Image } from 'App/Models/File'
import { ModelObject } from '@ioc:Adonis/Lucid/Orm';
import StoreTranslation from 'App/Models/translations/StoreTranslation';
import Store from 'App/Models/accounts/business/stores/Store';

export default class StoreTranslationsController {
  /**
    * returns the user's storeTranslations as pangination list
    * @param {HttpContextContract}
    * @returns {Promise<{meta: any;data: ModelObject[];}>}
    * @memberof StoreTranslationsController
    * @example
    * curl -X GET -H "Content-Type: application/json" -d '{"page": 1}' http://localhost:3333/api/v1/storeTranslations
    */
  public async index({ request, bouncer }: HttpContextContract): Promise<{
    meta: any;
    data: ModelObject[];
  }> {

    const payload = await request.validate(ListStoreTranslationsValidator)
    await bouncer.with('StoreTranslationPolicy').authorize('viewList', payload)
    var storeTranslationsQuery = StoreTranslation.query()
    var page = 1
    var limit = 12

    if (payload.search) {
      for (let i = 0; i < payload.search_in!.length; i++) {
        const element = payload.search_in![i];
        if (i == 0) {
          storeTranslationsQuery = storeTranslationsQuery.where(element, 'like', `%${payload.search}%`)
        } else {
          storeTranslationsQuery = storeTranslationsQuery.orWhere(element, 'like', `%${payload.search}%`)
        }
      }
    }
    if (payload.sort) {
      storeTranslationsQuery = storeTranslationsQuery.orderBy(payload.sort, payload.order)
    }
    if (payload.load) {
      for (const load of payload.load) {
        storeTranslationsQuery = storeTranslationsQuery.preload(load)
      }
    }
    if (payload.where) {
      for (const key in payload.where) {
        storeTranslationsQuery = storeTranslationsQuery.where(key, payload.where[key])
      }
    }
    page = payload.page || page
    limit = payload.limit || limit

    return (await storeTranslationsQuery.paginate(page, Math.min(limit, 24))).toJSON()
  }

  /**
   * creates a new storeTranslation for the user
   * @param {HttpContextContract}
   * @returns {Promise<{ storeTranslation: ModelObject; photo: Image | null; }>}
   * @memberof StoreTranslationsController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My StoreTranslation", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/storeTranslations
   */
  public async store({ request, bouncer }: HttpContextContract): Promise<{ store_translation: ModelObject }> {

    const payload = await request.validate(CreateStoreTranslationValidator)
    var store = (await Store.find(payload.store_id))!
    await bouncer.with('StoreTranslationPolicy').authorize('create', store)
    const storeTranslation = await StoreTranslation.create({
      locale: payload.locale,
      name: payload.name,
      description: payload.description,
      storeId: payload.store_id,
    })
    var json = storeTranslation.toJSON()
    return {
      store_translation: json
    }
  }

  /**
   * returns the storeTranslation info
   * @param {HttpContextContract}
   * @returns {Promise<StoreTranslation>}
   * @memberof StoreTranslationsController
   * @example
   * curl -X GET -H "Content-Type: application/json" http://localhost:3333/api/v1/storeTranslations/1
   */
  public async show({ request, bouncer }: HttpContextContract): Promise<any> {
    const payload = await request.validate(ShowStoreTranslationValidator)
    var storeTranslation = (await StoreTranslation.find(payload.params.id))!
    await bouncer.with('StoreTranslationPolicy').authorize('view', storeTranslation)
    if (payload.load) {
      for (const load of payload.load) {
        await storeTranslation.load(load)
      }
    }
    return {
      store_translation: storeTranslation.toJSON()
    }
  }

  /**
   * updates the storeTranslation info
   * @param {HttpContextContract}
   * @returns {Promise<StoreTranslation>}
   * @memberof StoreTranslationsController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My StoreTranslation", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/storeTranslations/1
   */
  public async update({ request, bouncer }: HttpContextContract): Promise<{
    store_translation: ModelObject;
  }> {
    // validate also params.id
    const payload = await request.validate(UpdateStoreTranslationValidator)
    const storeTranslation = (await StoreTranslation.find(payload.params.id))!
    await bouncer.with('StoreTranslationPolicy').authorize('update', storeTranslation)
    storeTranslation.name = payload.name ?? storeTranslation.name
    storeTranslation.description = payload.description ?? storeTranslation.description
    await storeTranslation.save()
    return {
      store_translation: storeTranslation.toJSON(),
    }
  }

  /**
   * deletes the storeTranslation
   * @param {HttpContextContract}
   * @returns {Promise<void>}
   * @memberof StoreTranslationsController
   * @example
   * curl -X DELETE -H "Content-Type: application/json" http://localhost:3333/api/v1/storeTranslations/{storeTranslationId}
   */
  public async destroy({ request, bouncer }: HttpContextContract): Promise<void> {
    const payload = await request.validate(DestroyStoreTranslationValidator)
    const storeTranslation = (await StoreTranslation.find(payload.params.id))!
    await bouncer.with('StoreTranslationPolicy').authorize('delete', storeTranslation)
    return await storeTranslation.delete()
  }


}

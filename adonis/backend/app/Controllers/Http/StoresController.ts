import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import  { CreateStoreValidator, DestroyStoreValidator, ListStoresValidator, ShowStoreValidator, UpdateStoreValidator } from 'App/Validators/StoreValidator'
import { Image } from 'App/Models/File'
import { ModelObject } from '@ioc:Adonis/Lucid/Orm';
import Store, { StoreStatus } from 'App/Models/accounts/business/stores/Store';

export default class StoresController {
  /**
    * returns the user's stores as pangination list
    * @param {HttpContextContract}
    * @returns {Promise<{meta: any;data: ModelObject[];}>}
    * @memberof StoresController
    * @example
    * curl -X GET -H "Content-Type: application/json" -d '{"page": 1}' http://localhost:3333/api/v1/stores
    */
  public async index({  request, bouncer }: HttpContextContract): Promise<{
    meta: any;
    data: ModelObject[];
  }> {
    const payload = await request.validate(ListStoresValidator)
    await bouncer.with('StorePolicy').authorize('viewList', payload)
    var storesQuery = Store.query().preload('photo')
    var page = 1
    var limit = 24

    if (payload.search) {
      storesQuery = storesQuery.where(payload.search_by!, 'like', `%${payload.search}%`)
    }
    if (payload.sort) {
      storesQuery = storesQuery.orderBy(payload.sort, payload.order)
    }
    if (payload.load) {
      for (const load of payload.load) {
        storesQuery = storesQuery.preload(load)
      }
    }
    if (payload.where) {
      for (const key in payload.where) {
        storesQuery = storesQuery.where(key, payload.where[key])
      }
    }
    page = payload.page || page
    limit = payload.limit || limit

    return (await storesQuery.paginate(page, Math.min(limit, 24))).toJSON()
  }

  /**
   * creates a new store for the user
   * @param {HttpContextContract}
   * @returns {Promise<{ store: ModelObject; photo: Image | null; }>}
   * @memberof StoresController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Store", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/stores
   */
  public async store({ request, bouncer }: HttpContextContract): Promise<{ store: ModelObject; photo: Image | null; }> {

    const payload = await request.validate(CreateStoreValidator)
    await bouncer.with('StorePolicy').authorize('create', payload)
    const store = await Store.create({
      name: payload.name,
      description: payload.description,
      status: StoreStatus.active,
      merchantProfileId: payload.merchant_profile_id,
    })
    var photo: Image | null = null;
    if (payload.photo) {
      photo = await store.setPhoto(payload.photo)
    }
    return {
      store: store.toJSON(),
      photo: photo,
    }
  }

  /**
   * returns the store info
   * @param {HttpContextContract}
   * @returns {Promise<Store>}
   * @memberof StoresController
   * @example
   * curl -X GET -H "Content-Type: application/json" http://localhost:3333/api/v1/stores/1
   */
  public async show({ request, bouncer }: HttpContextContract): Promise<any> {
    const payload = await request.validate(ShowStoreValidator)
    var store = (await Store.find(payload.params.id))!
    // await bouncer.with('StorePolicy').authorize('view', store)
    if (payload.load) {
      for (const load of payload.load) {
        await store!.load(load)
      }
    }
    if (!payload.load?.includes('photo')) {
      await store!.load('photo')
    }
    return store!.toJSON()
  }

  /**
   * updates the store info
   * @param {HttpContextContract}
   * @returns {Promise<Store>}
   * @memberof StoresController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Store", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/stores/1
   */
  public async update({ request, bouncer }: HttpContextContract): Promise<any> {
    // validate also params.id
    const payload = await request.validate(UpdateStoreValidator)
    const store = (await Store.find(payload.params.id))!
    await bouncer.with('StorePolicy').authorize('update', store)
    store.name = payload.name ?? store.name
    store.description = payload.description ?? store.description
    await store.save()
    var photo: Image | null = null;
    if (payload.photo) {
      photo = await store.setPhoto(payload.photo)
    }
    return {
      store: store.toJSON(),
      photo: photo,
    }
  }

  /**
   * deletes the store
   * @param {HttpContextContract}
   * @returns {Promise<void>}
   * @memberof StoresController
   * @example
   * curl -X DELETE -H "Content-Type: application/json" http://localhost:3333/api/v1/stores/{storeId}
   */
  public async destroy({ request, bouncer }: HttpContextContract): Promise<void> {
    const payload = await request.validate(DestroyStoreValidator)
    const store = (await Store.find(payload.params.id))!
    await bouncer.with('StorePolicy').authorize('delete', store)
    return await store.delete()
  }


}

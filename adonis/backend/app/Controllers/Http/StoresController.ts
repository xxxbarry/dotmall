import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import  { CreateStoreValidator, DestroyStoreValidator, ListStoresValidator, ShowStoreValidator, UpdateStoreValidator } from 'App/Validators/StoreValidator'
<<<<<<< HEAD
import { Image } from 'App/Models/File'
=======
import File, { Image } from 'App/Models/File'
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
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
<<<<<<< HEAD
    var storesQuery = Store.query().preload('photo')
    var page = 1
    var limit = 24

    if (payload.search) {
      storesQuery = storesQuery.where(payload.search_by!, 'like', `%${payload.search}%`)
=======
    var storesQuery = Store.query().preload('photos')
    var page = 1
    var limit = 12


    if (payload.search) {
      for (let i = 0; i < payload.search_in!.length; i++) {
        const element = payload.search_in![i];
        if (i == 0) {
          storesQuery = storesQuery.where(element, 'like', `%${payload.search}%`)
        } else {
          storesQuery = storesQuery.orWhere(element, 'like', `%${payload.search}%`)
        }
      }
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
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
<<<<<<< HEAD
  public async store({ request, bouncer }: HttpContextContract): Promise<{ store: ModelObject; photo: Image | null; }> {

=======
  public async store({ request,auth, bouncer }: HttpContextContract) {
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
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
<<<<<<< HEAD
      photo = await store.setPhoto(payload.photo)
    }
    return {
      store: store.toJSON(),
      photo: photo,
=======
      photo = await File.attachModel<Image>({
        related_id: store.id,
        file: payload.photo,
        tag: 'stores:photo',
        user_id: auth.user!.id,
      })
    }
    return {
      store: {
        ...store.toJSON(),
        photos: [...(()=>photo ? [photo]:[])()],
      },
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
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
<<<<<<< HEAD
    if (!payload.load?.includes('photo')) {
      await store!.load('photo')
    }
    return store!.toJSON()
=======
    if (!payload.load?.includes('photos')) {
      await store!.load('photos')
    }
    return {
      store: store.toJSON(),
    }
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
  }

  /**
   * updates the store info
   * @param {HttpContextContract}
   * @returns {Promise<Store>}
   * @memberof StoresController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Store", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/stores/1
   */
<<<<<<< HEAD
  public async update({ request, bouncer }: HttpContextContract): Promise<any> {
=======
  public async update({ request, auth,bouncer }: HttpContextContract): Promise<any> {
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
    // validate also params.id
    const payload = await request.validate(UpdateStoreValidator)
    const store = (await Store.find(payload.params.id))!
    await bouncer.with('StorePolicy').authorize('update', store)
    store.name = payload.name ?? store.name
    store.description = payload.description ?? store.description
    await store.save()
    var photo: Image | null = null;
    if (payload.photo) {
<<<<<<< HEAD
      photo = await store.setPhoto(payload.photo)
    }
    return {
      store: store.toJSON(),
      photo: photo,
=======
      photo = await File.attachModel<Image>({
        related_id: store.id,
        file: payload.photo,
        deleteOld: true,
        tag: 'stores:photo',
        user_id: auth.user!.id,
      })
    }
    return {
      store: {
        ...store.toJSON(),
        photos: [...(()=>photo ? [photo]:[])()],
      },
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
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

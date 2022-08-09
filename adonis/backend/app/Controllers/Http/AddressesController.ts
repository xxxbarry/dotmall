import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { CreateAddressValidator, DestroyAddressValidator, ListAddressesValidator, ShowAddressValidator, UpdateAddressValidator } from 'App/Validators/AddressValidator'
import File, { Image } from 'App/Models/File'
import { ModelObject } from '@ioc:Adonis/Lucid/Orm';
import Address from 'App/Models/Address';

export default class AddressesController {
  /**
    * returns the user's addresses as pangination list
    * @param {HttpContextContract}
    * @returns {Promise<{meta: any;data: ModelObject[];}>}
    * @memberof AddressesController
    * @example
    * curl -X GET -H "Content-Type: application/json" -d '{"page": 1}' http://localhost:3333/api/v1/addresses
    */
  public async index({ request, bouncer }: HttpContextContract): Promise<{
    meta: any;
    data: ModelObject[];
  }> {
    const payload = await request.validate(ListAddressesValidator)
    await bouncer.with('AddressPolicy').authorize('viewList', payload)
    var addressesQuery = Address.query()
    var page = 1
    var limit = 24

    if (payload.search) {
      for (let i = 0; i < payload.search_in!.length; i++) {
        const element = payload.search_in![i];
        if (i == 0) {
          addressesQuery = addressesQuery.where(element, 'like', `%${payload.search}%`)
        } else {
          addressesQuery = addressesQuery.orWhere(element, 'like', `%${payload.search}%`)
        }
      }
    }
    if (payload.sort) {
      addressesQuery = addressesQuery.orderBy(payload.sort, payload.order)
    }
    if (payload.load) {
      for (const load of payload.load) {
        addressesQuery = addressesQuery.preload(load)
      }
    }
    if (payload.where) {
      for (const key in payload.where) {
        addressesQuery = addressesQuery.where(key, payload.where[key])
      }
    }
    page = payload.page || page
    limit = payload.limit || limit

    return (await addressesQuery.paginate(page, Math.min(limit, 24))).toJSON()
  }

  /**
   * creates a new address for the user
   * @param {HttpContextContract}
   * @returns {Promise<{ address: ModelObject; photo: Image | null; }>}
   * @memberof AddressesController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Address", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/addresses
   */
  public async store({ request, bouncer }: HttpContextContract) {

    await bouncer.with('AddressPolicy').authorize('create', null)
    const payload = await request.validate(CreateAddressValidator)
    const address = await Address.create({
      primary: payload.primary,
      secondary: payload.secondary,
      city: payload.city,
      state: payload.state,
      country: payload.country,
      zip: payload.zip,
      userId: payload.user_id,
      latitude: payload.latitude,
      longitude: payload.longitude,
    })
    return {
      address: address.toJSON(),
    }
  }

  /**
   * returns the address info
   * @param {HttpContextContract}
   * @returns {Promise<Address>}
   * @memberof AddressesController
   * @example
   * curl -X GET -H "Content-Type: application/json" http://localhost:3333/api/v1/addresses/1
   */
  public async show({ auth, request, bouncer }: HttpContextContract): Promise<any> {
    const payload = await request.validate(ShowAddressValidator)
    var address = (await Address.find(payload.params.id))!
    await bouncer.with('AddressPolicy').authorize('view', address)
    if (payload.load) {
      for (const load of payload.load) {
        await address.load(load)
      }
    }
    return {address:address.toJSON()}
  }

  /**
   * updates the address info
   * @param {HttpContextContract}
   * @returns {Promise<Address>}
   * @memberof AddressesController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Address", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/addresses/1
   */
  public async update({ request, bouncer }: HttpContextContract): Promise<any> {
    // validate also params.id
    const payload = await request.validate(UpdateAddressValidator)
    const address = (await Address.find(payload.params.id))!
    await bouncer.with('AddressPolicy').authorize('update', address)
    address.primary = payload.primary ?? address.primary
    address.secondary = payload.secondary ?? address.secondary
    address.city = payload.city ?? address.city
    address.state = payload.state ?? address.state
    address.country = payload.country ?? address.country
    address.zip = payload.zip ?? address.zip
    address.userId = payload.user_id ?? address.userId
    address.latitude = payload.latitude ?? address.latitude
    address.longitude = payload.longitude ?? address.longitude
    await address.save()
    return {
      address: address.toJSON(),
    }
  }

  /**
   * deletes the address
   * @param {HttpContextContract}
   * @returns {Promise<void>}
   * @memberof AddressesController
   * @example
   * curl -X DELETE -H "Content-Type: application/json" http://localhost:3333/api/v1/addresses/{addressId}
   */
  public async destroy({ request, bouncer }: HttpContextContract): Promise<void> {
    const payload = await request.validate(DestroyAddressValidator)
    const address = (await Address.find(payload.params.id))!
    await bouncer.with('AddressPolicy').authorize('delete', address)
    return await address.delete()
  }


}

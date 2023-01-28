import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Account, { AccountType } from 'App/Models/Account'
import  { CreateAccountValidator, DestroyAccountValidator, ListAccountsValidator, ShowAccountValidator, UpdateAccountValidator } from 'App/Validators/AccountValidator'
import { Image } from 'App/Models/File'
import { ModelObject } from '@ioc:Adonis/Lucid/Orm';

export default class AccountsController {
  /**
    * returns the user's accounts as pangination list
    * @param {HttpContextContract}
    * @returns {Promise<{meta: any;data: ModelObject[];}>}
    * @memberof AccountsController
    * @example
    * curl -X GET -H "Content-Type: application/json" -d '{"page": 1}' http://localhost:3333/api/v1/accounts
    */
  public async index({ auth, request, bouncer }: HttpContextContract): Promise<{
    meta: any;
    data: ModelObject[];
  }> {
    const payload = await request.validate(ListAccountsValidator)
    await bouncer.with('AccountPolicy').authorize('viewList', payload)
    var accountsQuery = Account.query()
    var page = 1
    var limit = 24

    if (payload.search) {
      accountsQuery = accountsQuery.where(payload.search_by!, 'like', `%${payload.search}%`)
    }
    if (payload.sort) {
      accountsQuery = accountsQuery.orderBy(payload.sort, payload.order)
    }
    if (payload.load) {
      for (const load of payload.load) {
        accountsQuery = accountsQuery.preload(load)
      }
    }
    if (payload.where) {
      for (const key in payload.where) {
        accountsQuery = accountsQuery.where(key, payload.where[key])
      }
    }
    page = payload.page || page
    limit = payload.limit || limit

    return (await accountsQuery.paginate(page, Math.min(limit, 24))).toJSON()
  }

  /**
   * creates a new account for the user
   * @param {HttpContextContract}
   * @returns {Promise<{ account: ModelObject; photo: Image | null; }>}
   * @memberof AccountsController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Account", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/accounts
   */
  public async store({ request, auth, bouncer }: HttpContextContract): Promise<{ account: ModelObject; photo: Image | null; }> {

    await bouncer.with('AccountPolicy').authorize('create', null)
    const payload = await request.validate(CreateAccountValidator)
    const account = await auth.user!.related("accounts").create({
      name: payload.name,
      description: payload.description,
      type: payload.type as AccountType,
    })
    var photo: Image | null = null;
    if (payload.photo) {
      photo = await account.setPhoto(payload.photo)
    }
    return {
      account: account.toJSON(),
      photo: photo,
    }
  }

  /**
   * returns the account info
   * @param {HttpContextContract}
   * @returns {Promise<Account>}
   * @memberof AccountsController
   * @example
   * curl -X GET -H "Content-Type: application/json" http://localhost:3333/api/v1/accounts/1
   */
  public async show({ auth, request, bouncer }: HttpContextContract): Promise<any> {
    await bouncer.with('AccountPolicy').authorize('view', null)
    const payload = await request.validate(ShowAccountValidator)
    var account = await Account.query().where('id', payload.params.id).where('user_id', auth.user!.id).first()
    if (payload.load) {
      for (const load of payload.load) {
        await account!.load(load)
      }
    }
    if (!payload.load?.includes('photos')) {
      await account!.load('photos')
    }
    return account!.toJSON()
  }

  /**
   * updates the account info
   * @param {HttpContextContract}
   * @returns {Promise<Account>}
   * @memberof AccountsController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Account", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/accounts/1
   */
  public async update({ request, bouncer }: HttpContextContract): Promise<any> {
    // validate also params.id
    const payload = await request.validate(UpdateAccountValidator)
    const account = (await Account.find(payload.params.id))!
    await bouncer.with('AccountPolicy').authorize('update', account)
    account.name = payload.name ?? account.name
    account.description = payload.description ?? account.description
    await account.save()
    var photo: Image | null = null;
    if (payload.photo) {
      await account.setPhoto(payload.photo)
    }
    return {
      account: account.toJSON(),
      photo: photo,
    }
  }

  /**
   * deletes the account
   * @param {HttpContextContract}
   * @returns {Promise<void>}
   * @memberof AccountsController
   * @example
   * curl -X DELETE -H "Content-Type: application/json" http://localhost:3333/api/v1/accounts/{accountId}
   */
  public async destroy({ request, bouncer }: HttpContextContract): Promise<void> {
    const payload = await request.validate(DestroyAccountValidator)
    const account = (await Account.find(payload.params.id))!
    await bouncer.with('AccountPolicy').authorize('delete', account)
    return await account.delete()
  }


}

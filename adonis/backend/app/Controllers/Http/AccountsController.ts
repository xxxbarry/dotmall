import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Account, { AccountType } from 'App/Models/accounts/Account'
import CreateAccountValidator, { DestroyAccountValidator, ListAccountsValidator, ShowAccountValidator, UpdateAccountValidator } from 'App/Validators/AccountValidator'
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
  public async index({ auth, request }: HttpContextContract): Promise<{
    meta: any;
    data: ModelObject[];
  }> {
    const payload = await request.validate(ListAccountsValidator)
    var accountsQuery = auth.user!.related("accounts").query()
    var page = 1
    var limit = 24

    // if (payload.query) {
    if (payload.search) {
      accountsQuery = accountsQuery.where('name', 'like', `%${payload.search}%`)
    }
    if (payload.sort) {
      accountsQuery = accountsQuery.orderBy(payload.sort, payload.order)
    }
    if (payload.load) {
      for (const load of payload.load) {
        accountsQuery = accountsQuery.preload(load)
      }
    }
    page = payload.page || page
    limit = payload.limit || limit

    // }
    return (await accountsQuery.paginate(page, Math.min(limit, 24))).toJSON()
  }

  /**
   * creates a new account for the user
   * @param {HttpContextContract}
   * @returns {Promise<{ account: ModelObject; avatar: Image | null; }>}
   * @memberof AccountsController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Account", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/accounts
   */
  public async store({ request, auth }: HttpContextContract): Promise<{ account: ModelObject; avatar: Image | null; }> {
    const payload = await request.validate(CreateAccountValidator)
    const account = await auth.user!.related("accounts").create({
      name: payload.name,
      description: payload.description,
      type: payload.type as AccountType,
    })
    var avatar: Image | null = null;
    if (payload.avatar) {
      avatar = await account.setAvatar(payload.avatar)
    }
    return {
      account: account.toJSON(),
      avatar: avatar,
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
  public async show({ auth, request }: HttpContextContract) {
    const payload = await request.validate(ShowAccountValidator)
    var account = await Account.query().where('id', payload.params.id).where('user_id', auth.user!.id).first()
    await account!.load('avatar')
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
  public async update({ request }: HttpContextContract): Promise<any> {
    // validate also params.id
    const payload = await request.validate(UpdateAccountValidator)
    const account = (await Account.find(payload.params.id))!
    account.name = payload.name ?? account.name
    account.description = payload.description ?? account.description
    await account.save()
    var avatar: Image | null = null;
    if (payload.avatar) {
      await account.setAvatar(payload.avatar)
    }
    return {
      account: account.toJSON(),
      avatar: avatar,
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
  public async destroy({ request }: HttpContextContract): Promise<void> {
    const payload = await request.validate(DestroyAccountValidator)
    const account = await Account.find(payload.params.id)
    return await account!.delete()
  }


}

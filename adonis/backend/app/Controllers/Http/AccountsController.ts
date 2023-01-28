import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import Account, { AccountType } from 'App/Models/Account'
import  { CreateAccountValidator, DestroyAccountValidator, ListAccountsValidator, ShowAccountValidator, UpdateAccountValidator } from 'App/Validators/AccountValidator'
<<<<<<< HEAD
import { Image } from 'App/Models/File'
=======
import File, { Image } from 'App/Models/File'
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
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
    var limit = 12


    if (payload.search) {
<<<<<<< HEAD
      accountsQuery = accountsQuery.where(payload.search_by!, 'like', `%${payload.search}%`)
=======
      for (let i = 0; i < payload.search_in!.length; i++) {
        const element = payload.search_in![i];
        if (i == 0) {
          accountsQuery = accountsQuery.where(element, 'like', `%${payload.search}%`)
        } else {
          accountsQuery = accountsQuery.orWhere(element, 'like', `%${payload.search}%`)
        }
      }
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
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
<<<<<<< HEAD
  public async store({ request, auth, bouncer }: HttpContextContract): Promise<{ account: ModelObject; photo: Image | null; }> {

=======
  public async store({ request, auth, bouncer }: HttpContextContract) {
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
    await bouncer.with('AccountPolicy').authorize('create', null)
    const payload = await request.validate(CreateAccountValidator)
    const account = await Account.create({
      name: payload.name,
      description: payload.description,
      type: payload.type ,
      userId: payload.user_id,
    })
    var photo: Image | null = null;
    if (payload.photo) {
<<<<<<< HEAD
      photo = await account.setPhoto(payload.photo)
    }
    return {
      account: account.toJSON(),
      photo: photo,
=======
      photo = await File.attachModel<Image>({
        related_id: account.id,
        file: payload.photo,
        deleteOld: true,
        tag: 'accounts:avatar',
        user_id: auth.user!.id,
      })
    }
    return {
      account: {
        ...account.toJSON(),
        photos: [...(()=>photo ? [photo]:[])()],
      },
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
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
<<<<<<< HEAD
  public async show({ auth, request, bouncer }: HttpContextContract): Promise<any> {
    await bouncer.with('AccountPolicy').authorize('view', null)
    const payload = await request.validate(ShowAccountValidator)
    var account = await Account.query().where('id', payload.params.id).where('user_id', auth.user!.id).first()
=======
  public async show({ auth, request, bouncer }: HttpContextContract) {
    const payload = await request.validate(ShowAccountValidator)
    var account = await Account.query().where('id', payload.params.id).first()
    await bouncer.with('AccountPolicy').authorize('view', account)
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
    if (payload.load) {
      for (const load of payload.load) {
        await account!.load(load)
      }
    }
    if (!payload.load?.includes('photos')) {
      await account!.load('photos')
    }
<<<<<<< HEAD
    return account!.toJSON()
=======
    return {account:account!.toJSON()}
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
  }

  /**
   * updates the account info
   * @param {HttpContextContract}
   * @returns {Promise<Account>}
   * @memberof AccountsController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Account", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/accounts/1
   */
<<<<<<< HEAD
  public async update({ request, bouncer }: HttpContextContract): Promise<any> {
=======
  public async update({ request,auth, bouncer }: HttpContextContract): Promise<any> {
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
    // validate also params.id
    const payload = await request.validate(UpdateAccountValidator)
    const account = (await Account.find(payload.params.id))!
    await bouncer.with('AccountPolicy').authorize('update', account)
    account.name = payload.name ?? account.name
    account.description = payload.description ?? account.description
    account.type = payload.type ?? account.type;
    await account.save()
    var photo: Image | null = null;
    if (payload.photo) {
<<<<<<< HEAD
      await account.setPhoto(payload.photo)
=======
      photo = await File.attachModel<Image>({
        related_id: account.id,
        file: payload.photo,
        deleteOld: true,
        tag: 'accounts:avatar',
        user_id: auth.user!.id,
      })
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
    }
    var jsons = account.toJSON();
    return {
<<<<<<< HEAD
      account: account.toJSON(),
      photo: photo,
=======
      account: {
        ...jsons,
        photos: [...(()=>photo ? [photo]:[])()],
      },
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
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

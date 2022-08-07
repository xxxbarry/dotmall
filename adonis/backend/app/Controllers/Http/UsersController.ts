import { OpaqueTokenContract } from '@ioc:Adonis/Addons/Auth'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { ModelObject } from '@ioc:Adonis/Lucid/Orm'
import Phone from 'App/Models/ContactOptions/Phone'
import File, { Image } from 'App/Models/File'
import User,{ AuthPivotTags } from 'App/Models/User'
import SignupUserValidator, { CreateUserValidator, DestroyUserValidator, ListUsersValidator, ShowUserValidator, SigninUserValidator, UpdateUserValidator } from 'App/Validators/UserValidators'
import DotBaseModel from 'Dot/models/DotBaseModel'

export default class UsersController {
  /**
   * POST: /api/v1/auth/users/signup
   * @param {String} request.phone
   * @param {String} request.password
   * @return {Promise<SigninResponse>}
   * @memberof UsersController
   * @example
   * curl -X POST -H "Content-Type: application/json" -d '{"phone": "09123456789", "password": "123456"}' http://localhost:3333/api/v1/auth/users/signup
   */
  public async signup({ request, auth }: HttpContextContract): Promise<SigninResponse>  {
    const payload = await request.validate(SignupUserValidator)
    var user = await User.create({
      password: payload.password,
    })
    var phone = await Phone.create({
      value: payload.username,
      userId: user.id,
    })
    await user.related('phones').attach({
      [phone.id]: {
        id: DotBaseModel.generateId(),
        tag: AuthPivotTags.user,
      }
    })
    return {
      phones: [phone],
      user: user.toJSON(),
      token: await auth.use('api').generate(user),
    }
  }

  /**
   * POST: /api/v1/auth/users/signin
   * @param {String} request.phone
   * @param {String} request.password
   * @return {Promise<SigninResponse>}
   * @memberof UsersController
   * @example
   * curl -X POST -H "Content-Type: application/json" -d '{"phone": "09123456789", "password": "123456"}' http://localhost:3333/api/v1/auth/users/signin
   */
  public async signin({ request, auth }: HttpContextContract): Promise<SigninResponse> {
    const payload = await request.validate(SigninUserValidator)
    const phone   = await Phone.query().where('value', payload.username).first()
    const pivot   = await phone!.related("users").pivotQuery().where('tag', AuthPivotTags.user).first()
    const user    = await User.query().where('id', pivot.related_id).first()
    await auth.verifyCredentials(user!.id, payload.password)

    return {
      phones: [phone!.toJSON()],
      user: user!.toJSON(),
      token: await auth.use('api').generate(user!),
    }
  }

  /**
   * POST: /api/v1/auth/users/signout
   * post berear token on header
   * @return {Promise<void>}
   * @memberof UsersController
   * @example
   * curl -X POST -H "Authorization: Bearer <token>" http://localhost:3333/api/v1/auth/users/signout
   */
  public async signout({ auth }: HttpContextContract): Promise<void> {
    return await auth.logout()
  }

  /**
   * GET: /api/v1/auth/users/me
   * get user info
   * @return {Promise<User|void>}
   * @memberof UsersController
   * @example
   * curl -X GET -H "Authorization: Bearer <token>" http://localhost:3333/api/v1/auth/users/me
   */
  public async auth({ auth, response }: HttpContextContract): Promise<ModelObject | void> {
    await auth.check()
    const user = auth.user
    if (!user) {
      return response.notFound()
    }
    await user.load('phones')
    await user.load('accounts')
    await user.load('emails')
    return {
      user: user.toJSON()
    }
  }





  ///////////////////////////
    /**
    * returns the user's users as pangination list
    * @param {HttpContextContract}
    * @returns {Promise<{meta: any;data: ModelObject[];}>}
    * @memberof UsersController
    * @example
    * curl -X GET -H "Content-Type: application/json" -d '{"page": 1}' http://localhost:3333/api/v1/users
    */
     public async index({ request, bouncer }: HttpContextContract): Promise<{
      meta: any;
      data: ModelObject[];
    }> {
      const payload = await request.validate(ListUsersValidator)
      await bouncer.with('UserPolicy').authorize('viewList', payload)
      var usersQuery = User.query()
      var page = 1
      var limit = 24

      if (payload.search) {
        for (let i = 0; i < payload.search_in!.length; i++) {
          const element = payload.search_in![i];
          if (i == 0) {
            usersQuery = usersQuery.where(element, 'like', `%${payload.search}%`)
          } else {
            usersQuery = usersQuery.orWhere(element, 'like', `%${payload.search}%`)
          }
        }
      }
      if (payload.sort) {
        usersQuery = usersQuery.orderBy(payload.sort, payload.order)
      }
      if (payload.load) {
        for (const load of payload.load) {
          usersQuery = usersQuery.preload(load)
        }
      }
      if (payload.where) {
        for (const key in payload.where) {
          usersQuery = usersQuery.where(key, payload.where[key])
        }
      }
      page = payload.page || page
      limit = payload.limit || limit

      return (await usersQuery.paginate(page, Math.min(limit, 24))).toJSON()
    }

    /**
     * creates a new user for the user
     * @param {HttpContextContract}
     * @returns {Promise<{ user: ModelObject; photo: Image | null; }>}
     * @memberof UsersController
     * @example
     * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My User", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/users
     */
    public async store({ request, bouncer }: HttpContextContract) {

      await bouncer.with('UserPolicy').authorize('create', null)
      const payload = await request.validate(CreateUserValidator)
      const user = await User.create({
        password: payload.password,
      })
      return {
        user: user.toJSON(),
      }
    }

    /**
     * returns the user info
     * @param {HttpContextContract}
     * @returns {Promise<User>}
     * @memberof UsersController
     * @example
     * curl -X GET -H "Content-Type: application/json" http://localhost:3333/api/v1/users/1
     */
    public async show({ auth, request, bouncer }: HttpContextContract): Promise<any> {
      const payload = await request.validate(ShowUserValidator)
      var user = (await User.find(payload.params.id))!
      await bouncer.with('UserPolicy').authorize('view', user)
      if (payload.load) {
        for (const load of payload.load) {
          await user.load(load)
        }
      }
      return {user:user.toJSON()}
    }

    /**
     * updates the user info
     * @param {HttpContextContract}
     * @returns {Promise<User>}
     * @memberof UsersController
     * @example
     * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My User", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/users/1
     */
    public async update({ request, bouncer }: HttpContextContract): Promise<any> {
      // validate also params.id
      const payload = await request.validate(UpdateUserValidator)
      const user = (await User.find(payload.params.id))!
      await bouncer.with('UserPolicy').authorize('update', user)
      await user.save()
      return {
        user:user.toJSON(),
      }
    }

    /**
     * deletes the user
     * @param {HttpContextContract}
     * @returns {Promise<void>}
     * @memberof UsersController
     * @example
     * curl -X DELETE -H "Content-Type: application/json" http://localhost:3333/api/v1/users/{userId}
     */
    public async destroy({ request, bouncer }: HttpContextContract): Promise<void> {
      const payload = await request.validate(DestroyUserValidator)
      const user = (await User.find(payload.params.id))!
      await bouncer.with('UserPolicy').authorize('delete', user)
      return await user.delete()
    }
  }


/**
 * SigninResponse
 * @typedef {Object} SigninResponse
 * @property {String} token
 */
export interface SigninResponse  {
  token: OpaqueTokenContract<User>
  user: ModelObject
  [key: string]: any
}

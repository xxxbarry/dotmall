import { OpaqueTokenContract } from '@ioc:Adonis/Addons/Auth'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { ModelObject } from '@ioc:Adonis/Lucid/Orm'
import Phone from 'App/Models/ContactOptions/Phone'
import User from 'App/Models/User'
import SignupUserValidator, { SigninUserValidator, UpdateUserValidator } from 'App/Validators/UserValidators'

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
    var phone = await user.related('phones').create({
      value: payload.phone,
      relatedType: "User",
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
    const phone = (await Phone.query().where('related_type', "User").where('value', payload.phone).first())!
    var user = await auth.verifyCredentials(phone.relatedTo, payload.password)
    
    return {
      phones: [phone.toJSON()],
      user: user.toJSON(),
      token: await auth.use('api').generate(user),
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
  public async me({ auth, response }: HttpContextContract): Promise<User | void> {
    const user = auth.user
    if (!user) {
      return response.notFound()
    }
    await user.load('phones')
    await user.load('accounts')
    await user.load('emails')
    return user
  }

  /**
   * PUT: /api/v1/auth/users/me
   * update user info
   * example:
   * curl -X PUT -H "Authorization: Bearer <token>" -H "Content-Type: application/json" -d '{"name": "new name"}' http://localhost:3333/api/v1/auth/users/me
   * @return {Promise<User|void>}
   * @memberof UsersController
   */
  public async update({ auth, request, response }: HttpContextContract): Promise<User | void>  {
    const user = auth.user
    if (!user) {
      return response.notFound()
    }
    const payload = await request.validate(UpdateUserValidator)
    user.password = payload.password
    await user.save()
    return user
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

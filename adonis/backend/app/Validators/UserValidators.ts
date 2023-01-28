import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'

export default class SignupUserValidator implements DotValidator {
  constructor(protected ctx: HttpContextContract) {
  }
  public schema = schema.create({
    phone: schema.string({}, [
      rules.mobile(),
      rules.unique({ table: 'phones', column: 'value'}),
    ]),
    password: schema.string({}, [
      rules.minLength(6),
    ]),
  })

  public messages = {}
}
// export  class UpdateUserValidator implements DotValidator {
//   constructor(protected ctx: HttpContextContract) {
//   }
//   public schema = schema.create({
//     phone: schema.string({}, [
//       rules.mobile(),
//       // the phone number must be unique only where related_type is "User"
//       rules.unique({ table: 'phones', column: 'value', where: { related_type: 'User' } }),
//     ]),
//     password: schema.string({}, [
//       rules.minLength(6),
//     ]),
//   })

//   public messages = {}
// }


export class SigninUserValidator implements DotValidator {
  constructor(protected ctx: HttpContextContract) {

  }
  public refs = schema.refs({
    phoneModel: null
  })

  public schema = schema.create({
    phone: schema.string({}, [
      rules.mobile(),
      rules.authUserPhoneExists(),
    ]),
    password: schema.string({}, [
      rules.minLength(6),
    ]),
  }
  )
  public messages = {}
}

export class UpdateUserValidator implements DotValidator {
  constructor(protected ctx: HttpContextContract) {
  }
  public schema = schema.create({
    password: schema.string({}, [
      rules.minLength(6),
      rules.confirmed('password_confirmation'),
    ]),
  })

  public messages = {}
}

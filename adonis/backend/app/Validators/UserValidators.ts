import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'

export default class SignupUserValidator implements DotValidator {
  constructor(protected ctx: HttpContextContract) {
  }
  public schema = schema.create({
    username: schema.string({}, [
      rules.mobile(),
      rules.unique({ table: 'phones', column: 'value' }),
    ]),
    password: schema.string({}, [
      rules.minLength(6),
    ]),
  })

  public messages = {}
}
export  class UpdateUserValidator implements DotValidator {
  constructor(protected ctx: HttpContextContract) {
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'users', column: 'id' }),
      ]),
    }),
  })

  public messages = {}
}


export class SigninUserValidator implements DotValidator {
  constructor(protected ctx: HttpContextContract) {

  }
  public refs = schema.refs({
    phoneModel: null
  })

  public schema = schema.create({
    username: schema.string({}, [
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


/////////////////////////:


/**
 * CreateUserValidator
 */
export class CreateUserValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    password: schema.string({}, [
      rules.minLength(6),
    ]),
  })

  public messages = {}
}

/**
 * Show User Validator
 *
 */
export class ShowUserValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'users', column: 'id' }),
      ]),
    }),
    load: schema.array.optional().members(
      schema.enum.optional(["accounts", "emails", "phones", "files"] as const)
    ),
  })
  public messages = {}
}
/*
 * Destroy User Validator
 */
export class DestroyUserValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'users', column: 'id' }),
      ]),
    }),
  })

  public messages = {}
}

/*
 * List Users Validator
 * Handles the following:
 * - Pagination
 * - Sorting
 * - Filtering
 * - Searching
 * - Filtering
 *
 */
export class ListUsersValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    // query: schema.object().members({
    page: schema.number.optional(),
    limit: schema.number.optional([
      rules.range(1, 24),
    ]),
    sort: schema.enum.optional([] as const),
    order: schema.enum.optional(["asc", "desc"] as const),
    // type: schema.enum.optional(["personal', 'business"] as const),
    search: schema.string.optional([rules.minLength(1),]),
    search_in: schema.array.optional([rules.requiredIfExists('search')]).members(
      schema.enum([] as const)
    ),
    load: schema.array.optional().members(
      schema.enum.optional(["accounts", "emails", "phones", "files"] as const)
    ),
    where: schema.object.optional().members({})
  })

  public messages = {}
}

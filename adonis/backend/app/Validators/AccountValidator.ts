import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'
import { AccountType } from 'App/Models/Account'

export class CreateAccountValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    user_id: schema.string({ trim: true }, [
      rules.minLength(14),
      rules.exists({ table: 'users', column: 'id' }),
    ]),
    name: schema.string.optional(),
    description: schema.string.optional(),
<<<<<<< HEAD
    type: schema.string({}, []),
    // photo is optional, but if it is provided, it must be a valid image
    photo: schema.file.optional({}, [
    ]),
=======
    type: schema.enum<AccountType[]>(Object.values(AccountType) as AccountType[]),
    // photo is optional, but if it is provided, it must be a valid image
    photo: schema.file.optional({
      extnames: ['jpg', 'jpeg', 'png', 'gif', 'webp',  'bmp'],
      size: '2mb',
    },[]),
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
  })
  public messages = {}
}

/*
 * UpdateAccountValidator
 */
export class UpdateAccountValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'accounts', column: 'id' }),
      ]),
    }),
    name: schema.string.optional(),
    description: schema.string.optional(),
<<<<<<< HEAD
    // type: schema.string.optional(),
    // photo is optional, but if it is provided, it must be a valid image
    photo: schema.file.optional(),
=======
    // type is enum, but it is optional
    type: schema.enum.optional<AccountType[]>(Object.values(AccountType) as AccountType[]),
    // photo is optional, but if it is provided, it must be a valid image

    photo: schema.file.optional({
      extnames: ['jpg', 'jpeg', 'png', 'gif', 'webp',  'bmp'],
      size: '2mb',
    },[]),
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
  })

  public messages = {}
}
/*
 * Show Account Validator
 *
 */
export class ShowAccountValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'accounts', column: 'id' }),
      ]),
    }),
    load: schema.array.optional().members(
      schema.enum.optional(["users", "photos", "customer", "merchant",/* "merchant.store"*/] as const)
    ),
  })
  public messages = {}
}
/*
 * Destroy Account Validator
 */
export class DestroyAccountValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'accounts', column: 'id' }),
      ]),
    }),
  })

  public messages = {}
}

/*
 * List Accounts Validator
 * Handles the following:
 * - Pagination
 * - Sorting
 * - Filtering
 * - Searching
 * - Filtering
 *
 */
export class ListAccountsValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    // query: schema.object().members({
      page: schema.number.optional(),
      limit: schema.number.optional([
        rules.range(1, 24),
      ]),
      sort: schema.enum.optional(['name', 'type', 'created_at', 'updated_at'] as const),
      order: schema.enum.optional(["asc", "desc"] as const),
      // type: schema.enum.optional(["personal', 'business"] as const),
      search: schema.string.optional([rules.minLength(1),]),
<<<<<<< HEAD
      search_by:
        schema.enum.optional(["name"] as const, [rules.requiredIfExists('search')]),
      load: schema.array.optional().members(
        schema.enum(["users", "photos", "customer", "merchant",/* "merchant.store"*/] as const)
      ),
      where: schema.object().members({
=======
      search_in: schema.array.optional([rules.requiredIfExists('search')]).members(
        schema.enum(["name"] as const)
      ),
      load: schema.array.optional().members(
        schema.enum(["users", "photos", "customer", "merchant",/* "merchant.store"*/] as const)
      ),
      where: schema.object.optional().members({
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
        user_id: schema.string.optional(),
        type: schema.enum.optional(["business", "business"] as const),
        name: schema.string.optional(),
        description: schema.string.optional(),
      })
  })

  public messages = {}
}

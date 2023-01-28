import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'

export class CreateCustomerProfileValidator implements DotValidator {
  constructor(protected ctx: HttpContextContract) {
  }
  public schema = schema.create({
    account_id: schema.string({}, [
      rules.required(),
      rules.exists({ table: 'accounts', column: 'id' }),
    ]),

  })

  public messages = {}
}

/**
<<<<<<< HEAD
 * UpdateCustomerProfileValidator 
=======
 * UpdateCustomerProfileValidator
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
 */
export class UpdateCustomerProfileValidator implements DotValidator {
  constructor(protected ctx: HttpContextContract) {

  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'customer_profiles', column: 'id'}),
      ]),
    }),
    name: schema.string.optional(),
    description: schema.string.optional(),
    // type: schema.string.optional(),
    // photo is optional, but if it is provided, it must be a valid image
<<<<<<< HEAD
    photo: schema.file.optional(),
=======

    photo: schema.file.optional({
      extnames: ['jpg', 'jpeg', 'png', 'gif', 'webp',  'bmp'],
      size: '2mb',
    },[]),
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
  })

  public messages = {}
}
/**
 * Show CustomerProfile Validator
 *
 */
export class ShowCustomerProfileValidator implements DotValidator {
  constructor(protected ctx: HttpContextContract) {

  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'customer_profiles', column: 'id' }),
      ]),
    }),
    load: schema.array.optional().members(
      schema.enum.optional(["addresses",  "account", "phones", "emails"] as const)
    ),
  })
  public messages = {}
}
/**
<<<<<<< HEAD
 * Destroy CustomerProfile Validator 
=======
 * Destroy CustomerProfile Validator
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
 */
export class DestroyCustomerProfileValidator implements DotValidator {
  constructor(protected ctx: HttpContextContract) {

  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'customer_profiles', column: 'id', }),
      ]),
    }),
  })

  public messages = {}
}

/**
 * List CustomerProfiles Validator
 * Handles the following:
 * - Pagination
 * - Sorting
 * - Filtering
 * - Searching
 * - Filtering
<<<<<<< HEAD
 * 
=======
 *
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
 */
export class ListCustomerProfilesValidator implements DotValidator {
  constructor(protected ctx: HttpContextContract) {

  }
  public schema = schema.create({
<<<<<<< HEAD
    page: schema.number.optional([
      rules.range(1, Infinity),
    ]),
=======
    page: schema.number.optional(),
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
    limit: schema.number.optional([
      rules.range(1, 24),
    ]),
    sort: schema.enum.optional(['created_at', 'updated_at'] as const),
    order: schema.enum.optional(["asc", "desc"] as const),
    search: schema.string.optional([rules.minLength(1),]),
<<<<<<< HEAD
    search_by: schema.enum.optional(["id"] as const, [rules.requiredIfExists('search')]),
    load: schema.array.optional().members(
      schema.enum.optional(["addresses", "account", "phones", "emails"] as const)
    ),
    where: schema.object().members({
=======
    search_in: schema.array.optional([rules.requiredIfExists('search')]).members(
      schema.enum([] as const)
    ),
    load: schema.array.optional().members(
      schema.enum.optional(["addresses", "account", "phones", "emails"] as const)
    ),
    where: schema.object.optional().members({
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
      account_id: schema.string.optional(),
    })

  })

  public messages = {}
}

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
 * UpdateCustomerProfileValidator 
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
    photo: schema.file.optional(),
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
 * Destroy CustomerProfile Validator 
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
 * 
 */
export class ListCustomerProfilesValidator implements DotValidator {
  constructor(protected ctx: HttpContextContract) {

  }
  public schema = schema.create({
    page: schema.number.optional([
      rules.range(1, Infinity),
    ]),
    limit: schema.number.optional([
      rules.range(1, 24),
    ]),
    sort: schema.enum.optional(['created_at', 'updated_at'] as const),
    order: schema.enum.optional(["asc", "desc"] as const),
    search: schema.string.optional([rules.minLength(1),]),
    search_by: schema.enum.optional(["id"] as const, [rules.requiredIfExists('search')]),
    load: schema.array.optional().members(
      schema.enum.optional(["addresses", "account", "phones", "emails"] as const)
    ),
    where: schema.object().members({
      account_id: schema.string.optional(),
    })

  })

  public messages = {}
}

import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'

export class CreateMerchantProfileValidator implements DotValidator {
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
 * UpdateMerchantProfileValidator
 */
export class UpdateMerchantProfileValidator implements DotValidator {
  constructor(protected ctx: HttpContextContract) {

  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'merchant_profiles', column: 'id'}),
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
 * Show MerchantProfile Validator
 *
 */
export class ShowMerchantProfileValidator implements DotValidator {
  constructor(protected ctx: HttpContextContract) {

  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'merchant_profiles', column: 'id' }),
      ]),
    }),
    load: schema.array.optional().members(
      schema.enum.optional(["address", "stores", "account", "phones", "emails"] as const)
    ),
  })
  public messages = {}
}
/**
 * Destroy MerchantProfile Validator
 */
export class DestroyMerchantProfileValidator implements DotValidator {
  constructor(protected ctx: HttpContextContract) {

  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'merchant_profiles', column: 'id', }),
      ]),
    }),
  })

  public messages = {}
}

/**
 * List MerchantProfiles Validator
 * Handles the following:
 * - Pagination
 * - Sorting
 * - Filtering
 * - Searching
 * - Filtering
 *
 */
export class ListMerchantProfilesValidator implements DotValidator {
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
    search_by: schema.array.optional([rules.requiredIfExists('search')]).members(
      schema.enum([] as const)
    ),
    load: schema.array.optional().members(
      schema.enum.optional(["address", "stores", "account", "phones", "emails"] as const)
    ),
    where: schema.object.optional().members({
      account_id: schema.string.optional(),
    })

  })

  public messages = {}
}

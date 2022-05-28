import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'

export default class CreateMerchantProfileValidator implements DotValidator {
  constructor(protected ctx: HttpContextContract) {
  }
  public schema = schema.create({
    account_id: schema.string({}, [
      rules.required(),
      rules.exists({ table: 'accounts', column: 'id'}),
    ]),

  })

  public messages = {}
}

/*
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
        rules.exists({ table: 'accounts', column: 'id', where: { user_id: this.ctx.auth.user!.id } }),
      ]),
    }),
    name: schema.string.optional(),
    description: schema.string.optional(),
    // type: schema.string.optional(),
    // avatar is optional, but if it is provided, it must be a valid image
    avatar: schema.file.optional(),
  })

  public messages = {}
}
/*
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
        // rules.exists({ table: 'merchant_profiles', column: 'id', where: { account_id: this.ctx.auth.user!.id } }),
      ]),
    }),
  })
  public messages = {}
}
/*
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
        rules.exists({ table: 'accounts', column: 'id', where: { user_id: this.ctx.auth.user!.id } }),
      ]),
    }),
  })

  public messages = {}
}

/*
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
    // query: schema.object().members({
      page: schema.number.optional([
        rules.range(1, Infinity),
      ]),
      limit: schema.number.optional([
        rules.range(1, 24),
      ]),
      sort: schema.enum.optional(['name', 'type', 'created_at', 'updated_at'] as const),
      order: schema.enum.optional(["asc", "desc"] as const),
      // type: schema.enum.optional(["personal', 'business"] as const),
      search: schema.string.optional([rules.minLength(1),]),
      // filter: schema.string.optional({}, [
      //   rules.minLength(1),
      // ]),
      load: schema.array.optional().members(
        schema.enum.optional(["address", "stores", "account",] as const)
      ),

    // }),
  })

  public messages = {}
}

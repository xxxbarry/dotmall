import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'

export default class CreateAccountValidator implements DotValidator {
  constructor(protected ctx: HttpContextContract) {
  }
  public schema = schema.create({
    name: schema.string.optional(),
    description: schema.string.optional(),
    type: schema.string({}, []),
    // avatar is optional, but if it is provided, it must be a valid image
    avatar: schema.file.optional({}, [
    ]),
  })

  public messages = {}
}

/*
 * UpdateAccountValidator 
 */
export class UpdateAccountValidator implements DotValidator {
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
 * Show Account Validator
 *
 */
export class ShowAccountValidator implements DotValidator {
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
 * Destroy Account Validator 
 */
export class DestroyAccountValidator implements DotValidator {
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
 * List Accounts Validator
 * Handles the following:
 * - Pagination
 * - Sorting
 * - Filtering
 * - Searching
 * - Filtering
 * 
 */
export class ListAccountsValidator implements DotValidator {
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
        schema.enum.optional(["user", "avatar", "customer", "merchant",/* "merchant.store"*/] as const)
      ),

    // }),
  })

  public messages = {}
}

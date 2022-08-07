import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'

export class CreateStoreTranslationValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({

    store_id: schema.string({}, [
      rules.required(),
      rules.exists({ table: 'stores', column: 'id' }),
    ]),
    name: schema.string.optional(),
    description: schema.string.optional(),
    locale: schema.string({}, [
      rules.required(),
    ]),
  })

  public messages = {}
}

/*
 * UpdateStoreValidator
 */
export class UpdateStoreTranslationValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'store_translations', column: 'id' }),
      ]),
    }),
    name: schema.string.optional(),
    description: schema.string.optional(),
  })

  public messages = {}
}
/*
 * Show Store Validator
 *
 */
export class ShowStoreTranslationValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'store_translations', column: 'id' }),
      ]),
    }),

    load: schema.array.optional().members(
      schema.enum.optional([
        "store"] as const)
    ),
  })
  public messages = {}
}
/*
 * Destroy Store Validator
 */
export class DestroyStoreTranslationValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'store_translations', column: 'id' }),
      ]),
    }),
  })

  public messages = {}
}

/*
 * List Stores Validator
 * Handles the following:
 * - Pagination
 * - Sorting
 * - Filtering
 * - Searching
 * - Filtering
 *
 */
export class ListStoreTranslationsValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    // query: schema.object().members({
    page: schema.number.optional(),
    limit: schema.number.optional([
      rules.range(1, 24),
    ]),
    sort: schema.enum.optional(["name", "description", 'locale', 'created_at', 'updated_at'] as const),
    order: schema.enum.optional(["asc", "desc"] as const),
    // type: schema.enum.optional(["personal', 'business"] as const),
    search: schema.string.optional([rules.minLength(1),]),
    search_in: schema.array.optional([rules.requiredIfExists('search')]).members(
      schema.enum(["name", "description", 'locale'] as const)
    ),
    load: schema.array.optional().members(
      schema.enum(["store"] as const)
    ),
    where: schema.object.optional().members({
      locale: schema.string.optional(),
      name: schema.string.optional(),
      description: schema.string.optional(),
      store_id: schema.string.optional([
        rules.exists({ table: 'stores', column: 'id' }),
      ])
    })
  })

  public messages = {}
}

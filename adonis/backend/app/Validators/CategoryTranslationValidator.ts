import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'

export class CreateCategoryTranslationValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({

    category_id: schema.string({}, [
      rules.exists({ table: 'categories', column: 'id' }),
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
 * UpdateCategoryValidator
 */
export class UpdateCategoryTranslationValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'category_translations', column: 'id' }),
      ]),
    }),
    name: schema.string.optional(),
    description: schema.string.optional(),

  })

  public messages = {}
}
/*
 * Show Category Validator
 *
 */
export class ShowCategoryTranslationValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'category_translations', column: 'id' }),
      ]),
    }),

    load: schema.array.optional().members(
      schema.enum.optional([
        "category"] as const)
    ),
  })
  public messages = {}
}
/*
 * Destroy Category Validator
 */
export class DestroyCategoryTranslationValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'category_translations', column: 'id' }),
      ]),
    }),
  })

  public messages = {}
}

/*
 * List Categories Validator
 * Handles the following:
 * - Pagination
 * - Sorting
 * - Filtering
 * - Searching
 * - Filtering
 *
 */
export class ListCategoryTranslationsValidator extends DotValidator {
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
      schema.enum(["category"] as const)
    ),
    where: schema.object.optional().members({
      locale: schema.string.optional(),
      name: schema.string.optional(),
      description: schema.string.optional(),
      category_id: schema.string.optional([
        rules.exists({ table: 'categories', column: 'id' }),
      ])
    })
  })

  public messages = {}
}

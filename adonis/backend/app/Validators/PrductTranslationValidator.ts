import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'

export class CreateProductTranslationValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({

    product_id: schema.string.optional({}, [
      rules.exists({ table: 'products', column: 'id' }),
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
 * UpdateProductValidator
 */
export class UpdateProductTranslationValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'product_translations', column: 'id' }),
      ]),
    }),
    name: schema.string.optional(),
    description: schema.string.optional(),
  })

  public messages = {}
}
/*
 * Show Product Validator
 *
 */
export class ShowProductTranslationValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'product_translations', column: 'id' }),
      ]),
    }),

    load: schema.array.optional().members(
      schema.enum.optional([
        "product"] as const)
    ),
  })
  public messages = {}
}
/*
 * Destroy Product Validator
 */
export class DestroyProductTranslationValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'product_translations', column: 'id' }),
      ]),
    }),
  })

  public messages = {}
}

/*
 * List Products Validator
 * Handles the following:
 * - Pagination
 * - Sorting
 * - Filtering
 * - Searching
 * - Filtering
 *
 */
export class ListProductTranslationsValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    // query: schema.object().members({
    page: schema.number.optional([
      rules.range(1, Infinity),
    ]),
    limit: schema.number.optional([
      rules.range(1, 24),
    ]),
    sort: schema.enum.optional(["name", "description", 'locale', 'created_at', 'updated_at'] as const),
    order: schema.enum.optional(["asc", "desc"] as const),
    // type: schema.enum.optional(["personal', 'business"] as const),
    search: schema.string.optional([rules.minLength(1),]),
    search_by: schema.array.optional([rules.requiredIfExists('search')]).members(
      schema.enum(["name", "description", 'locale'] as const)
    ),
    load: schema.array.optional().members(
      schema.enum(["product"] as const)
    ),
    where: schema.object.optional().members({
      locale: schema.string.optional(),
      name: schema.string.optional(),
      description: schema.string.optional(),
      product_id: schema.string.optional([
        rules.exists({ table: 'products', column: 'id' }),
      ])
    })
  })

  public messages = {}
}

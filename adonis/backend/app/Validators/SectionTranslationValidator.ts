import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'

export class CreateSectionTranslationValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({

    section_id: schema.string.optional({}, [
      rules.exists({ table: 'sections', column: 'id' }),
    ]),
    name: schema.string.optional(),
    description: schema.string.optional(),
    slug: schema.string.optional(),
    locale: schema.string({}, [
      rules.required(),
    ]),
  })

  public messages = {}
}

/*
 * UpdateSectionValidator
 */
export class UpdateSectionTranslationValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'section_translations', column: 'id' }),
      ]),
    }),
    name: schema.string.optional(),
    description: schema.string.optional(),
  })

  public messages = {}
}
/*
 * Show Section Validator
 *
 */
export class ShowSectionTranslationValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.minLength(14),
        rules.exists({ table: 'section_translations', column: 'id' }),
      ]),
    }),

    load: schema.array.optional().members(
      schema.enum.optional([
        "section"] as const)
    ),
  })
  public messages = {}
}
/*
 * Destroy Section Validator
 */
export class DestroySectionTranslationValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.minLength(14),
        rules.exists({ table: 'section_translations', column: 'id' }),
      ]),
    }),
  })

  public messages = {}
}

/*
 * List Sections Validator
 * Handles the following:
 * - Pagination
 * - Sorting
 * - Filtering
 * - Searching
 * - Filtering
 *
 */
export class ListSectionTranslationsValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    // query: schema.object().members({
    page: schema.number.optional(),
    limit: schema.number.optional([
      rules.range(1, 24),
    ]),
    sort: schema.enum.optional(["name", "description", 'slug', 'locale', 'created_at', 'updated_at'] as const),
    order: schema.enum.optional(["asc", "desc"] as const),
    // type: schema.enum.optional(["personal', 'business"] as const),
    search: schema.string.optional([rules.minLength(1),]),
    search_in: schema.array.optional([rules.requiredIfExists('search')]).members(
      schema.enum(["name", "description", 'slug', 'locale'] as const)
    ),
    load: schema.array.optional().members(
      schema.enum(["section"] as const)
    ),
    where: schema.object.optional().members({
      locale: schema.string.optional(),
      name: schema.string.optional(),
      description: schema.string.optional(),
      slug: schema.string.optional(),
      store_id: schema.string.optional([
        rules.exists({ table: 'sections', column: 'id' }),
      ]),
      section_id: schema.string.optional([
        rules.exists({ table: 'sections', column: 'id' }),
      ])
    })
  })

  public messages = {}
}

import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'

/**
 * CreateSectionValidator
 */
export class CreateSectionValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    name: schema.string.optional(),
    description: schema.string.optional(),
    photo: schema.file.optional({}, [
    ]),
    store_id: schema.string({}, [
      rules.required(),
      rules.exists({ table: 'stores', column: 'id' }),
    ]),
  })

  public messages = {}
}

/**
 * UpdateSectionValidator
 */
export class UpdateSectionValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'sections', column: 'id' }),
      ]),
    }),
    name: schema.string.optional(),
    description: schema.string.optional(),
    // photo is optional, but if it is provided, it must be a valid image
    photo: schema.file.optional(),
  })

  public messages = {}
}
/**
 * Show Section Validator
 *
 */
export class ShowSectionValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'sections', column: 'id' }),
      ]),
    }),
    load: schema.array.optional().members(
      schema.enum.optional(["parent", "children", "translations","photo"] as const)
    ),
  })
  public messages = {}
}
/*
 * Destroy Section Validator
 */
export class DestroySectionValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'sections', column: 'id' }),
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
export class ListSectionsValidator extends DotValidator {
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
      sort: schema.enum.optional(['name', 'description', 'created_at', 'updated_at'] as const),
      order: schema.enum.optional(["asc", "desc"] as const),
      // type: schema.enum.optional(["personal', 'business"] as const),
      search: schema.string.optional([rules.minLength(1),]),
      search_by: schema.array.optional([rules.requiredIfExists('search')]).members(
        schema.enum(["name","description"] as const)
      ),
      load: schema.array.optional().members(
        schema.enum.optional(["parent", "children","photo",
        "translations"] as const)
      ),
      where: schema.object.optional().members({
        store_id: schema.string.optional([
          rules.exists({ table: 'stores', column: 'id' }),
        ]),
        name: schema.string.optional(),
        description: schema.string.optional(),
      })
  })

  public messages = {}
}

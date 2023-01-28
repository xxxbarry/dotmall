import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'

/**
<<<<<<< HEAD
 * CreateCategoryValidator 
=======
 * CreateCategoryValidator
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
 */
export class CreateCategoryValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    name: schema.string.optional(),
    description: schema.string.optional(),
<<<<<<< HEAD
    photo: schema.file.optional({}, [
    ]),
=======

    photo: schema.file.optional({
      extnames: ['jpg', 'jpeg', 'png', 'gif', 'webp',  'bmp'],
      size: '2mb',
    },[])
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
  })

  public messages = {}
}

/**
<<<<<<< HEAD
 * UpdateCategoryValidator 
=======
 * UpdateCategoryValidator
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
 */
export class UpdateCategoryValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'categories', column: 'id' }),
      ]),
    }),
    name: schema.string.optional(),
    description: schema.string.optional(),
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
 * Show Category Validator
<<<<<<< HEAD
 * 
=======
 *
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
 */
export class ShowCategoryValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'categories', column: 'id' }),
      ]),
    }),
    load: schema.array.optional().members(
<<<<<<< HEAD
      schema.enum.optional(["parent", "children", "translations","photo"] as const)
=======
      schema.enum.optional(["parent", "children", "translations", "photos"] as const)
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
    ),
  })
  public messages = {}
}
/*
<<<<<<< HEAD
 * Destroy Category Validator 
=======
 * Destroy Category Validator
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
 */
export class DestroyCategoryValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'categories', column: 'id' }),
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
<<<<<<< HEAD
 * 
=======
 *
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
 */
export class ListCategoriesValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    // query: schema.object().members({
<<<<<<< HEAD
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
      search_by: 
        schema.enum.optional(["name","description"] as const, [rules.requiredIfExists('search')]),
      load: schema.array.optional().members(
        schema.enum.optional(["parent", "children", "translations","photo",] as const)
      ),
      where: schema.object().members({
        user_id: schema.string.optional(),
        type: schema.enum.optional(["business", "business"] as const),
        name: schema.string.optional(),
        description: schema.string.optional(),
      })
=======
    page: schema.number.optional(),
    limit: schema.number.optional([
      rules.range(1, 24),
    ]),
    sort: schema.enum.optional(['name', 'description', 'created_at', 'updated_at'] as const),
    order: schema.enum.optional(["asc", "desc"] as const),
    // type: schema.enum.optional(["personal', 'business"] as const),
    search: schema.string.optional([rules.minLength(1),]),
    search_in: schema.array.optional([rules.requiredIfExists('search')]).members(
      schema.enum(["name", "description"] as const)
    ),
    load: schema.array.optional().members(
      schema.enum.optional(["parent", "children", "translations", "photos"] as const)
    ),
    where: schema.object.optional().members({
      name: schema.string.optional(),
      description: schema.string.optional(),
    })
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
  })

  public messages = {}
}

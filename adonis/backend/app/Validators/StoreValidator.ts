import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'

export class CreateStoreValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({

    merchant_profile_id: schema.string({}, [
<<<<<<< HEAD
      rules.required(),
=======
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
      rules.exists({ table: 'merchant_profiles', column: 'id' }),
    ]),
    name: schema.string.optional(),
    description: schema.string.optional(),
<<<<<<< HEAD
    photo: schema.file.optional({}, []),
=======

    photo: schema.file.optional({
      extnames: ['jpg', 'jpeg', 'png', 'gif', 'webp',  'bmp'],
      size: '2mb',
    },[])
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
  })

  public messages = {}
}

/*
<<<<<<< HEAD
 * UpdateStoreValidator 
=======
 * UpdateStoreValidator
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
 */
export class UpdateStoreValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'stores', column: 'id' }),
      ]),
    }),
    name: schema.string.optional(),
    description: schema.string.optional(),
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
/*
 * Show Store Validator
 *
 */
export class ShowStoreValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'stores', column: 'id' }),
      ]),
    }),

    load: schema.array.optional().members(
      schema.enum.optional([
        "products",
        "categories",
        "orders",
        "address",
        "email",
        "phone",
<<<<<<< HEAD
        "photo",
        "merchant"] as const)
=======
        "photos",
        "merchant",
        "translations",] as const)
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
    ),
  })
  public messages = {}
}
/*
<<<<<<< HEAD
 * Destroy Store Validator 
=======
 * Destroy Store Validator
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
 */
export class DestroyStoreValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'stores', column: 'id' }),
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
<<<<<<< HEAD
 * 
=======
 *
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
 */
export class ListStoresValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    // query: schema.object().members({
<<<<<<< HEAD
      page: schema.number.optional([
        rules.range(1, Infinity),
      ]),
=======
      page: schema.number.optional(),
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
      limit: schema.number.optional([
        rules.range(1, 24),
      ]),
      sort: schema.enum.optional(['name', 'type', 'created_at', 'updated_at'] as const),
      order: schema.enum.optional(["asc", "desc"] as const),
      // type: schema.enum.optional(["personal', 'business"] as const),
      search: schema.string.optional([rules.minLength(1),]),
<<<<<<< HEAD
      search_by: 
        schema.enum.optional(["name"] as const, [rules.requiredIfExists('search')]),
=======
      search_in: schema.array.optional([rules.requiredIfExists('search')]).members(
        schema.enum(["name","description"] as const)
      ),
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
      load: schema.array.optional().members(
        schema.enum.optional([
          "products",
          "categories",
          "orders",
          "address",
          "email",
          "phone",
<<<<<<< HEAD
          "photo",
          "merchant"] as const)
      ),
      where: schema.object().members({
=======
          "photos",
          "merchant",
        "translations"] as const)
      ),
      where: schema.object.optional().members({
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
        merchant_profile_id: schema.string.optional(),
        status: schema.enum.optional([0,1,2] as const),
        name: schema.string.optional(),
        description: schema.string.optional(),
      })
  })

  public messages = {}
}

import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'
import { ProductStatus, ProductType } from 'App/Models/accounts/business/stores/Product'

/**
 * CreateProductValidator
 */
export class CreateProductValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    name: schema.string({}, [
      rules.minLength(3),
      rules.maxLength(255),
    ]),
    description: schema.string({}, [
      rules.minLength(3),
      rules.maxLength(255),
    ]),
    body: schema.string.optional(),
    slug: schema.string.optional(),
    status: schema.number.optional(),
    quantity: schema.number.optional(),
    barcode: schema.string.optional(),
    type: schema.enum(Object.values(ProductType) as ProductType[]),
    price: schema.number([
    ]),
    meta: schema.object.optional().anyMembers(),
    store_id: schema.string({}, [
      rules.exists({ table: 'stores', column: 'id' }),
    ]),
    section_id: schema.string({}, [
      rules.exists({ table: 'sections', column: 'id' }),
    ]),
    photo: schema.file.optional({
      extnames: ['jpg', 'jpeg', 'png', 'gif', 'webp',  'bmp'],
      size: '2mb',
    },[])
  })

  public messages = {}
}

/**
 * UpdateProductValidator
 */
export class UpdateProductValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.minLength(14),
        rules.exists({ table: 'products', column: 'id' }),
      ]),
    }),
    name: schema.string({}, [
      rules.minLength(3),
      rules.maxLength(255),
    ]),
    description: schema.string({}, [
      rules.minLength(3),
      rules.maxLength(255),
    ]),
    body: schema.string.optional(),
    slug: schema.string.optional(),
    barcode: schema.string.optional(),
    type: schema.enum.optional<ProductType[]>(Object.values(ProductType) as ProductType[]),
    price: schema.number(),
    status: schema.enum.optional<ProductStatus[]>(Object.values(ProductStatus) as ProductStatus[]),
    quantity: schema.number.optional(),
    meta: schema.object.optional().anyMembers(),
    store_id: schema.string({}, [
      rules.exists({ table: 'stores', column: 'id' }),
    ]),
    section_id: schema.string({}, [
      rules.exists({ table: 'sections', column: 'id' }),
    ]),
    photo: schema.file.optional({
      extnames: ['jpg', 'jpeg', 'png', 'gif', 'webp',  'bmp'],
      size: '2mb',
    },[])
  })

  public messages = {}
}
/**
 * Show Product Validator
 *
 */
export class ShowProductValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'products', column: 'id' }),
      ]),
    }),
    load: schema.array.optional().members(
      schema.enum.optional(["section", "store", "translations", "photo"] as const)
    ),
  })
  public messages = {}
}
/*
 * Destroy Product Validator
 */
export class DestroyProductValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'products', column: 'id' }),
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
export class ListProductsValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    // query: schema.object().members({
    page: schema.number.optional(),
    limit: schema.number.optional([
      rules.range(1, 24),
    ]),

    sort: schema.enum.optional([
      'name',
      'description',
      'body',
      'slug',
      'barcode',
      'type',
      'price',
      'created_at',
      'updated_at'] as const),
    order: schema.enum.optional(["asc", "desc"] as const),
    // type: schema.enum.optional(["personal', 'business"] as const),
    search: schema.string.optional([rules.minLength(1),]),
    search_in: schema.array.optional([rules.requiredIfExists('search')]).members(
      schema.enum([
        'name',
        'description',
        'body',
        'slug',
        'barcode',
        'type',
        'price'
      ] as const)
    ),
    load: schema.array.optional().members(
      schema.enum.optional(["section", "store", "translations", "photo"] as const)
    ),
    where: schema.object.optional().members({
      name: schema.string.optional(),
      description: schema.string.optional(),
    })
  })

  public messages = {}
}

import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'
import { OrderStatus } from 'App/Models/Order'

/**
 * CreateOrderValidator
 */
export class CreateOrderValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }

  public schema = schema.create({
    status: schema.enum(Object.values(OrderStatus) as OrderStatus[]),
    address_id: schema.string(
      [rules.exists({ table: 'addresses', column: 'id' })]
    ),
    customer_profile_id: schema.string(
      [rules.exists({ table: 'customer_profiles', column: 'id' })]
    ),
    // items is array of objects with product_id and quantity
    items: schema.array().members(
      schema.object().members({
        product_id: schema.string([rules.exists({table: 'products', column: 'id',})]),
        // quantity must be a number less than product quantity
        quantity: schema.number([
          // must be larger than 0
        ]),
      })
    ),
  })

  public messages = {}
}

/**
 * UpdateOrderValidator
 */
export class UpdateOrderValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'orders', column: 'id' }),
      ]),
    }),
    status: schema.number.optional(),
    closed_at: schema.date.optional(),
    address_id: schema.string.optional(
      [rules.exists({ table: 'addresses', column: 'id' })]),
    customer_profile_id: schema.string.optional(
      [rules.exists({ table: 'customer_profiles', column: 'id' })])
  })

  public messages = {}
}
/**
 * Show Order Validator
 *
 */
export class ShowOrderValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'orders', column: 'id' }),
      ]),
    }),
    load: schema.array.optional().members(
      schema.enum.optional(["address", "customerProfile"] as const)
    ),
  })
  public messages = {}
}
/*
 * Destroy Order Validator
 */
export class DestroyOrderValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'orders', column: 'id' }),
      ]),
    }),
  })

  public messages = {}
}

/*
 * List Orders Validator
 * Handles the following:
 * - Pagination
 * - Sorting
 * - Filtering
 * - Searching
 * - Filtering
 *
 */
export class ListOrdersValidator extends DotValidator {
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
      "status",
      "closed_at"
      , 'created_at'
      , 'updated_at'] as const),
    order: schema.enum.optional(["asc", "desc"] as const),
    // type: schema.enum.optional(["personal', 'business"] as const),
    search: schema.string.optional([rules.minLength(1),]),
    search_in: schema.array.optional([rules.requiredIfExists('search')]).members(
      schema.enum([] as const)
    ),
    load: schema.array.optional().members(
      schema.enum.optional(["address", "customerProfile"] as const)
    ),
    where: schema.object.optional().members({
      status: schema.number.optional(),
      address_id: schema.string.optional(
        [rules.exists({ table: 'addresses', column: 'id' })]),
      customer_profile_id: schema.string.optional(
        [rules.exists({ table: 'customer_profiles', column: 'id' })]),
      created_at: schema.date.optional(),
      updated_at: schema.date.optional(),
      deleted_at: schema.date.optional(),
      closed_at: schema.date.optional(),

    })
  })

  public messages = {}
}

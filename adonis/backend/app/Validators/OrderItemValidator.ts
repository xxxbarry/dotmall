import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'

/**
 * CreateOrderItemValidator
 */
export class CreateOrderItemValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }

  public schema = schema.create({
    quantity: schema.number(),
    price: schema.number(),
    order_id: schema.string(
      [rules.exists({ table: 'orders', column: 'id' })]
    ),
    product_id: schema.string(
      [rules.exists({ table: 'products', column: 'id' })]
    )
  })

  public messages = {}
}

/**
 * UpdateOrderItemValidator
 */
export class UpdateOrderItemValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'order_items', column: 'id' }),
      ]),
    }),
    quantity: schema.number.optional(),
    price: schema.number.optional(),
    order_id: schema.string.optional(
      [rules.exists({ table: 'orders', column: 'id' })]
    ),
    product_id: schema.string.optional(
      [rules.exists({ table: 'products', column: 'id' })]
    )
  })

  public messages = {}
}
/**
 * Show OrderItem Validator
 *
 */
export class ShowOrderItemValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'order_items', column: 'id' }),
      ]),
    }),
    load: schema.array.optional().members(
      schema.enum.optional(["order","product"] as const)
    ),
  })
  public messages = {}
}
/*
 * Destroy OrderItem Validator
 */
export class DestroyOrderItemValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'order_items', column: 'id' }),
      ]),
    }),
  })

  public messages = {}
}

/*
 * List OrderItems Validator
 * Handles the following:
 * - Pagination
 * - Sorting
 * - Filtering
 * - Searching
 * - Filtering
 *
 */
export class ListOrderItemsValidator extends DotValidator {
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
      "quantity",
      "price",
    ] as const),
    order: schema.enum.optional(["asc", "desc"] as const),
    search: schema.string.optional([rules.minLength(1),]),
    search_in: schema.array.optional([rules.requiredIfExists('search')]).members(
      schema.enum([] as const)
    ),
    load: schema.array.optional().members(
      schema.enum.optional(["order","product"] as const)
    ),
    where: schema.object.optional().members({
      quantity: schema.number.optional(),
      price: schema.number.optional(),
    })
  })

  public messages = {}
}

import { schema, rules } from '@ioc:Adonis/Core/Validator'
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import DotValidator from './DotValidator'

/**
 * CreateAddressValidator
 */
export class CreateAddressValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }

  public schema = schema.create({
    primary: schema.string(),
    secondary: schema.string.optional(),
    city: schema.string.optional(),
    state: schema.string.optional(),
    zip: schema.string.optional(),
    country: schema.string.optional(),
    latitude: schema.number.optional(),
    longitude: schema.number.optional(),
    user_id: schema.string(
      [rules.exists({ table: 'users', column: 'id' })]
    )
  })

  public messages = {}
}

/**
 * UpdateAddressValidator
 */
export class UpdateAddressValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'addresses', column: 'id' }),
      ]),
    }),
    primary: schema.string.optional(),
    secondary: schema.string.optional(),
    city: schema.string.optional(),
    state: schema.string.optional(),
    zip: schema.string.optional(),
    country: schema.string.optional(),
    latitude: schema.number.optional(),
    longitude: schema.number.optional(),
    user_id: schema.string.optional(
      [rules.exists({ table: 'users', column: 'id' })]
    )
  })

  public messages = {}
}
/**
 * Show Address Validator
 *
 */
export class ShowAddressValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'addresses', column: 'id' }),
      ]),
    }),
    load: schema.array.optional().members(
      schema.enum.optional(["user"] as const)
    ),
  })
  public messages = {}
}
/*
 * Destroy Address Validator
 */
export class DestroyAddressValidator extends DotValidator {
  constructor(protected ctx: HttpContextContract) {
    super()
  }
  public schema = schema.create({
    params: schema.object().members({
      id: schema.string({ trim: true }, [
        rules.required(),
        rules.minLength(14),
        rules.exists({ table: 'addresses', column: 'id' }),
      ]),
    }),
  })

  public messages = {}
}

/*
 * List Addresses Validator
 * Handles the following:
 * - Pagination
 * - Sorting
 * - Filtering
 * - Searching
 * - Filtering
 *
 */
export class ListAddressesValidator extends DotValidator {
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
      "primary",
      "secondary",
      "city",
      "state",
      "zip",
      "country",
      "latitude",
      "longitude"
      ,'created_at'
      ,'updated_at'] as const),
    order: schema.enum.optional(["asc", "desc"] as const),
    // type: schema.enum.optional(["personal', 'business"] as const),
    search: schema.string.optional([rules.minLength(1),]),
    search_in: schema.array.optional([rules.requiredIfExists('search')]).members(
      schema.enum([
        "primary",
        "secondary",
        "city",
        "state",
        "zip",
        "country",
        "latitude",
        "longitude",] as const)
    ),
    load: schema.array.optional().members(
      schema.enum.optional(["user"] as const)
    ),
    where: schema.object.optional().members({
      primary: schema.string.optional(),
      secondary: schema.string.optional(),
      city: schema.string.optional(),
      state: schema.string.optional(),
      zip: schema.string.optional(),
      country: schema.string.optional(),
      latitude: schema.string.optional(),
      longitude: schema.string.optional(),
    })
  })

  public messages = {}
}

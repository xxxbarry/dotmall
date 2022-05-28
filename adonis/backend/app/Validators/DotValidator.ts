import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { ParsedTypedSchema,  TypedSchema } from '@ioc:Adonis/Core/Validator'

export default abstract class DotValidator {
    public schema
    public messages
}
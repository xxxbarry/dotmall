import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { ParsedTypedSchema,  TypedSchema } from '@ioc:Adonis/Core/Validator'

export default abstract class DotValidator {
    public schema
    public messages
}

/**
 * DotValidators
 * covers all the validators for the dot model
 * specially [index, store, show, update, destroy]
 */
export class DotValidators {
    public index?: typeof DotValidator
    public store?: typeof DotValidator
    public show?: typeof DotValidator
    public update?: typeof DotValidator
    public destroy?: typeof DotValidator
    public constructor({ index, store, show, update, destroy }: { index?: typeof DotValidator, store?: typeof DotValidator, show?: typeof DotValidator, update?: typeof DotValidator, destroy?: typeof DotValidator }) {
        this.index = index
        this.store = store
        this.show = show
        this.update = update
        this.destroy = destroy
    }
}
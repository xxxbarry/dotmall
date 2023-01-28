import { BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
<<<<<<< HEAD
import DotBaseModel from '../../../dot/models/DotBaseModel'
=======
import DotBaseModel, { DotBaseTranslation } from '../../../dot/models/DotBaseModel'
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
import Product from '../accounts/business/stores/Product'

export default class ProductTranslation extends DotBaseTranslation {
  @column()
  public locale: string

  @column()
  public name: string | null

  @column()
  public description: string | null

  @column()
  public slug: string | null

  @column()
  public body: string | null

  @column()
  public productId: string

  @belongsTo(() => Product)
  public product: BelongsTo<typeof Product>
}

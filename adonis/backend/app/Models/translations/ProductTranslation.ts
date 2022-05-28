import { BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from '../../../dot/models/DorBaseModel'
import Product from '../accounts/business/stores/Product'

export default class ProductTranslation extends DotBaseModel {
  @column()
  public locale: string

  @column()
  public name: string | null

  @column()
  public description: string | null

  @column()
  public body: string | null

  @column()
  public price: number | null

  @column()
  public productId: string

  @belongsTo(() => Product)
  public product: BelongsTo<typeof Product>
}
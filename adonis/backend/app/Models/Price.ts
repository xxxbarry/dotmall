import { BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from 'Dot/models/DotBaseModel'
import Product from './accounts/business/stores/Product'

export default class Price extends DotBaseModel {
  @column()
  public value: number

  @column()
  public currencyId: string

  @column()
  public productId: string

  @belongsTo(() => Product)
  public product: BelongsTo<typeof Product>
}

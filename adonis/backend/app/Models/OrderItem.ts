import { BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from 'Dot/models/DotBaseModel'
import Product from './accounts/business/stores/Product'
import Order from './Order'

export default class OrderItem extends DotBaseModel {
  @column()
  public productId: string

  @column()
  public orderId: string

  @column()
  public quantity: number

  @column()
  public price: number

  @belongsTo(() => Product)
  public product: BelongsTo<typeof Product>

  @belongsTo(() => Order)
  public order: BelongsTo<typeof Order>

}


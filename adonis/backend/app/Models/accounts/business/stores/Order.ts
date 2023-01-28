import { DateTime } from 'luxon'
<<<<<<< HEAD
import { BaseModel, column } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from '../../../../../dot/models/DotBaseModel'
=======
import { BaseModel, BelongsTo, belongsTo, column, HasOne, hasOne } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from '../../../../../dot/models/DotBaseModel'
import Address from 'App/Models/Address'
import CustomerProfile from '../../profiles/CustomerProfile'
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

export default class Order extends DotBaseModel {
  @column()
  public status: OrderStatus

  @column()
  public closedAt: DateTime | null

  @column()
  public customerProfileId: string | null

  @column()
  public addressId: string | null

  @belongsTo(() => Address)
  public address: BelongsTo<typeof Address>

  @belongsTo(() => CustomerProfile)
  public customerProfile: BelongsTo<typeof CustomerProfile>

  @column({
    prepare: (value) => JSON.stringify(value),
    consume: (value: string) => JSON.parse(value),
  })
  public items: OrderItem[]

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
}

export enum OrderStatus {
  pending = 0,
  confirmed = 1,
  canceled = 2,
  completed = 3,
}

// OrderItem
export interface OrderItem {
  productId: string
  quantity: number
  price: number
}

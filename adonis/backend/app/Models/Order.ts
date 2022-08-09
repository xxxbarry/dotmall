import { BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from 'Dot/models/DotBaseModel'
import { DateTime } from 'luxon'
import CustomerProfile from './accounts/profiles/CustomerProfile'
import Address from './Address'

export default class Order extends DotBaseModel {
  @column()
  public addressId: string

  @column()
  public status: OrderStatus

  @column()
  public customerProfileId: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime|null

  @column.dateTime()
  public deletedAt: DateTime|null

  @column.dateTime()
  public closedAt: DateTime|null

  @belongsTo(() => Address)
  public address: BelongsTo<typeof Address>

  @belongsTo(() => CustomerProfile,{
    onQuery(query) {
      // preload the account
      query.preload('account')
    },
  })
  public customerProfile: BelongsTo<typeof CustomerProfile>
}

export enum OrderStatus {
  pending = 0,
  active = 1,
  inactive = 2,
  suspended = 3,
}

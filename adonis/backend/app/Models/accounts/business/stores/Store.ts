import { DateTime } from 'luxon'
import {  belongsTo, BelongsTo, column, hasMany, HasMany, hasOne, HasOne } from '@ioc:Adonis/Lucid/Orm'
import Product from './Product'
import Category from './Category'
import Order from './Order'
import Address from 'App/Models/Address'
import Email from 'App/Models/ContactOptions/Email'
import Phone from 'App/Models/ContactOptions/Phone'
import { Image } from 'App/Models/File'
import MerchantProfile from '../../profiles/MerchantProfile'
import DotBaseModel from '../../../../../dot/models/DorBaseModel'
export enum StoreStatus {
    active = 0,
    inactive = 1,
    suspended = 2,
}
export default class Store extends DotBaseModel {

  @column()
  public name: string

  @column()
  public description: string|null

  //status
  @column()
  public status: StoreStatus

  @column.dateTime()
  public validatedAt: DateTime|null

  @column.dateTime()
  public deletedAt: DateTime|null

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  // Relations
  @hasMany(() => Product)
  public products: HasMany<typeof Product>

  @hasMany(() => Category)
  public categories: HasMany<typeof Category>

  @hasMany(() => Order)
  public orders: HasMany<typeof Order>

  // has address
  @hasOne(() => Address, { foreignKey: 'related_to' })
  public address: HasOne<typeof Address>

  @hasOne(() => Email, { foreignKey: 'related_to' })
  public email: HasOne<typeof Email>

  @hasOne(() => Phone, { foreignKey: 'related_to' })
  public phone: HasOne<typeof Phone>

  @hasOne(() => Image, { foreignKey: 'related_to' })
  public avatar: HasOne<typeof Image>

  // belongs to

  @belongsTo(() => MerchantProfile)
  public merchant: BelongsTo<typeof MerchantProfile>

  // merchantProfileId
  @column({serializeAs: null})
  public merchantProfileId: string

  // the user that created the account who is the owner of the store
  
}

<<<<<<< HEAD
import { belongsTo, BelongsTo, column, HasMany, hasMany, HasManyThrough, hasManyThrough, hasOne, HasOne, LucidModel } from '@ioc:Adonis/Lucid/Orm'
import Store from '../business/stores/Store'
import Address from 'App/Models/Address'
import Account from 'App/Models/Account'
import { ProfileModel } from './Profile'
export default class MerchantProfile extends ProfileModel {
=======
import { belongsTo, BelongsTo, column, HasMany, hasMany, hasOne, HasOne, LucidModel } from '@ioc:Adonis/Lucid/Orm'
import Store from '../business/stores/Store'
import Address from 'App/Models/Address'
import Account from 'App/Models/Account'
import Phone from 'App/Models/ContactOptions/Phone'
import Email from 'App/Models/ContactOptions/Email'
import DotBaseModel from 'Dot/models/DotBaseModel'

export default class MerchantProfile extends DotBaseModel {

  @column()
  public relatedId: string

  @hasMany(() => Email, {
      foreignKey: "relatedId",
      onQuery: (builder) => {
          builder.where('related_type', 'profiles:emails')
      }
  })
  public emails: HasMany<typeof Email>

  @hasMany(() => Phone, {
      foreignKey: "relatedId",
      onQuery: (builder) => {
          builder.where('related_type', 'profiles:phones')
      }
  })
  public phones: HasMany<typeof Phone>

>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
  @column()
  public accountId: string

  @hasOne(() => Address, {
    foreignKey: "relatedId",
    onQuery: (builder) => {
      builder.where('related_type', 'merchants:address')
    }
  })
  public address: HasOne<typeof Address>
  // has many stores
  @hasMany(() => Store)
  public stores: HasMany<typeof Store>

  @belongsTo(() => Account)
  public account: BelongsTo<typeof Account>



}

// create class HasManyByLanguage extends HasMany and override the query builder
// to filter by language

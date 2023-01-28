import { belongsTo, BelongsTo, column, HasMany, hasMany, HasManyThrough, hasManyThrough, hasOne, HasOne, LucidModel } from '@ioc:Adonis/Lucid/Orm'
import Store from '../business/stores/Store'
import Address from 'App/Models/Address'
import Account from 'App/Models/Account'
import { ProfileModel } from './Profile'
export default class MerchantProfile extends ProfileModel {
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

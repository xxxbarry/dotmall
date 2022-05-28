import { belongsTo, BelongsTo, column, HasMany, hasMany, hasOne, HasOne, LucidModel } from '@ioc:Adonis/Lucid/Orm'
import { HumanGender, ProfileModel } from './Profile'
import Store from '../business/stores/Store'
import Account from '../Account'
import Address from 'App/Models/Address'
export default class MerchantProfile extends ProfileModel {
  @column()
  public accountId: string

  @hasOne(() => Address, { foreignKey: 'relatedTo' })
  public address: HasOne<typeof Address>
  // has many stores
  @hasMany(() => Store)
  public stores: HasMany<typeof Store>

  @belongsTo(() => Account)
  public account: BelongsTo<typeof Account>

}

// create class HasManyByLanguage extends HasMany and override the query builder
// to filter by language

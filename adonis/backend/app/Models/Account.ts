import { afterDelete, beforeFetch, BelongsTo, belongsTo, column, hasOne, HasOne, ManyToMany, ModelQueryBuilderContract } from '@ioc:Adonis/Lucid/Orm'
import { usedPivot, usePivot } from 'Dot/hooks/orm'
import DotBaseModel from '../../dot/models/DotBaseModel'
import { BusinessAccountData } from './accounts/business/BusinessAccountData'
import { PersonalAccountData } from './accounts/PersonalAccountData'
import CustomerProfile from './accounts/profiles/CustomerProfile'
import MerchantProfile from './accounts/profiles/MerchantProfile'
import { Image } from './File'
import User from './User'
export default class Account extends DotBaseModel {
  static table: string = 'accounts'
  @column()
  public type: AccountType

  @column()
  public name: string

  @column()
  public description: string | null

  @column()
  public userId: string
  @belongsTo(() => User)
  public users: BelongsTo<typeof User>

  @column({
    prepare: (value: BusinessAccountData | PersonalAccountData) => JSON.stringify(value),
    consume: (value: string) => JSON.parse(value),
  })
  public data: BusinessAccountData | PersonalAccountData

  @usePivot(() => Image)
  public photos: ManyToMany<typeof Image>

  // load photo after fetch
  @beforeFetch()
  public static async loadPhoto(query: ModelQueryBuilderContract<typeof Account>) {
    query.preload('photos')
  }


  @hasOne(() => CustomerProfile, {
    foreignKey: "relatedId",
    onQuery: (builder) => {
      builder.where('related_type', 'accounts:customer')
      builder.preload('addresses')
      builder.preload('phones')
      builder.preload('emails')
    }
  })
  public customer: HasOne<typeof CustomerProfile>

  @hasOne(() => MerchantProfile, {
    foreignKey: "relatedId",
    onQuery: (builder) => {
      builder.where('related_type', 'accounts:merchant')
      builder.preload('address')
      builder.preload('phones')
      builder.preload('emails')
      builder.preload('stores')
    }
  })
  public merchant: HasOne<typeof MerchantProfile>

  // before delete, delete photo
  @afterDelete()
  public static async deletePhoto(instance: Account) {
    var photo = await Image.findBy('relatedId', instance.id)
    if (photo) {
      await photo.delete()
    }
  }


}
export abstract class AccountData {
  constructor(data: any) {
    for (let key in data) {
      this[key] = data[key]
    }
  }
}

export enum AccountType {
  business = 'business',
  personal = 'personal',
}

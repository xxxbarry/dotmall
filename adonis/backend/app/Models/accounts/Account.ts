import { afterDelete, beforeFetch, belongsTo, BelongsTo, column, HasOne, hasOne,  ModelQueryBuilderContract } from '@ioc:Adonis/Lucid/Orm'
import User from '../User'
import DotBaseModel from '../../../dot/models/DorBaseModel'
import CustomerProfile from './profiles/CustomerProfile'
import MerchantProfile from './profiles/MerchantProfile'
import { Image } from '../File'
import { BusinessAccountData } from './business/BusinessAccountData'
import { PersonalAccountData } from './PersonalAccountData'
import { MultipartFileContract } from '@ioc:Adonis/Core/BodyParser'

export enum AccountType {
  business = 'business',
  personal = 'personal',
}
export default class Account extends DotBaseModel {

  @column()
  public type: AccountType

  @column()
  public name: string

  @column()
  public description: string | null

  @column()
  public userId: string
  
  @column({
    prepare: (value: BusinessAccountData|PersonalAccountData) => JSON.stringify(value),
    consume: (value: string) => JSON.parse(value),
  })
  public data: BusinessAccountData|PersonalAccountData

  @hasOne(() => Image, { foreignKey: "relatedTo", 
    onQuery: (builder) => {
      builder.where('related_type', 'user_account_avatar')
    }
  })
  public avatar: HasOne<typeof Image>

  @belongsTo(() => User)
  public user: BelongsTo<typeof User>

  @hasOne(() => CustomerProfile, { foreignKey: "relatedTo",
    onQuery: (builder) => {
      builder.preload('addresses')
      builder.preload('phones')
      builder.preload('emails')
    }
  })
  public customer: HasOne<typeof CustomerProfile>

  @hasOne(() => MerchantProfile, { foreignKey: "relatedTo", 
    onQuery: (builder) => {
      builder.preload('address')
      builder.preload('phones')
      builder.preload('emails')
      builder.preload('stores')
    }
  })
  public merchant: HasOne<typeof MerchantProfile>
  // load avatar after fetch
  @beforeFetch()
  public static async loadAvatar(query: ModelQueryBuilderContract<typeof Account>) {
    query.preload('avatar')
  }

  // before delete, delete avatar
  @afterDelete()
  public static async deleteAvatar(instance: Account) {
    var avatar = await Image.findBy('relatedTo', instance.id)
    if (avatar) {
      await avatar.delete()
    }
  }

  /**
   * set avatar from MultipartFile
   * @param {MultipartFileContract} image
   * @param {boolean} [deleteOld=false]
   * @returns {Promise<Image>}
   */
  public async setAvatar(image: MultipartFileContract, deleteOld: boolean = true): Promise<Image> {
    var currentAvatar = await Image.findBy('relatedTo', this.id)
    var avatar = await Image.uploadAndCreate<Image>({
      multipartFile: image,
      relatedTo: this.id,
      relatedType: Account,
    })
    if (deleteOld && avatar && currentAvatar) {
      await currentAvatar.delete()
    }
    return avatar
  }
}
export abstract class AccountData  {
  constructor(data: any) {
    for (let key in data) {
      this[key] = data[key]
    }
  }
}

import { MultipartFileContract } from '@ioc:Adonis/Core/BodyParser'
import { column, ManyToMany, beforeFetch, ModelQueryBuilderContract, hasOne, HasOne, afterDelete, manyToMany } from '@ioc:Adonis/Lucid/Orm'
import { usePivot, usedPivot } from 'Dot/hooks/orm'
import DotBaseModel from 'Dot/models/DotBaseModel'
import Email from '../ContactOptions/Email'
import Phone from '../ContactOptions/Phone'
import { Image } from '../File'
import User from '../User'
import { BusinessAccountData } from './business/BusinessAccountData'
import { PersonalAccountData } from './PersonalAccountData'
import CustomerProfile from './profiles/CustomerProfile'
import MerchantProfile from './profiles/MerchantProfile'

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

  /**
   * set photo from MultipartFile
   * @param {MultipartFileContract} image
   * @param {boolean} [deleteOld=false]
   * @returns {Promise<Image>}
   */
  public async setPhoto(image: MultipartFileContract, deleteOld: boolean = true): Promise<Image> {
    var currentPhoto = await Image.query().where('related_type', 'accounts:photo').where('related_id', this.id).first()
    var photo = await Image.uploadAndCreate<Image>({
      multipartFile: image,
      relatedId: this.id,
      relatedType: `${Account.table}:photo`,
    })
    if (deleteOld && photo && currentPhoto) {
      await currentPhoto.delete()
    }
    return photo
  }

  @manyToMany(()=>User, {
    pivotForeignKey: 'phone_id',
    pivotRelatedForeignKey: 'related_id',
    pivotTable: "phones_pivot",
    pivotColumns: ['tag'],
    onQuery: (builder) => {
      // if (tag) {
      //   builder.wherePivot('tag', tag);
      // }
    }
  })
  public users: ManyToMany<typeof User>
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

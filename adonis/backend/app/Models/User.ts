import { DateTime } from 'luxon'
import Hash from '@ioc:Adonis/Core/Hash'
import { column, beforeSave, BaseModel, hasMany, HasMany, beforeFetch, afterCreate, hasManyThrough, HasManyThrough } from '@ioc:Adonis/Lucid/Orm'
import Email from './ContactOptions/Email'
import Phone from './ContactOptions/Phone'
import Account from './accounts/Account'
import DotBaseModel from '../../dot/models/DorBaseModel'
import MerchantProfile from './accounts/profiles/MerchantProfile'

export default class User extends DotBaseModel {
  // hasPermission(mp: ModelPermission) {
  //   var permission = this.related('permissions').where('value', mp.value).first()
  // }

  @column({ serializeAs: null })
  public password: string

  @column()
  public rememberMeToken?: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @beforeSave()
  public static async hashPassword(user: User) {
    if (user.$dirty.password) {
      user.password = await Hash.make(user.password)
    }
  }
  // Relations
  @hasMany(() => Email, { foreignKey: 'relatedTo'})
  public emails: HasMany<typeof Email>

  @hasMany(() => Phone, { foreignKey: 'relatedTo'})
  public phones: HasMany<typeof Phone>

  @hasMany(() => Account, {
    onQuery: (builder) => {
      // builder.preload('merchant')
      // builder.preload('customer')
      // builder.preload('avatar')
    }
  })
  public accounts: HasMany<typeof Account>

  // has many through relationship with merchants
  @hasManyThrough([() => MerchantProfile, () => Account],
    {
      onQuery: (builder) => {
        builder.preload('address')
        builder.preload('phones')
        builder.preload('emails')
        builder.preload('stores')
      }
    }
  )
  public merchants: HasManyThrough<typeof MerchantProfile, typeof Account>

  // user has many Permissions
  // @hasMany(() => Permission, { foreignKey: 'relatedTo'})
  // public permissions: HasMany<typeof Permission>

  // @afterCreate()
  // public static async createPermission(model: User) {
  //   await model.related('permissions').create({
  //     relatedType: model.constructor.name,
  //     value: "user#"+model.id+".*",
  //   })
  // }
}

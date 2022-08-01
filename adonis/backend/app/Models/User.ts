import { DateTime } from 'luxon'
import Hash from '@ioc:Adonis/Core/Hash'
import { column, beforeSave, ManyToMany, manyToMany, hasMany, HasMany } from '@ioc:Adonis/Lucid/Orm'
import Email from './ContactOptions/Email'
import Phone from './ContactOptions/Phone'
import DotBaseModel from '../../dot/models/DotBaseModel'
import { usePivot } from '../../dot/hooks/orm'
import Account from './accounts/Account'

export enum AuthPivotTags {
  user = "auth:users"
}
export default class User extends DotBaseModel {
  public table = 'users'

  // @usePivot(() => Account)
  @hasMany(() => Account)
  public accounts: HasMany<typeof Account>


  @usePivot(() => Email)
  public emails: ManyToMany<typeof Email>


  @manyToMany(()=>Phone, {
    pivotForeignKey: 'related_id',
    pivotRelatedForeignKey: 'phone_id',
    pivotTable: "phones_pivot",
    pivotColumns: ['tag'],
    onQuery: (builder) => {
      // if (tag) {
      //   builder.wherePivot('tag', tag);
      // }
    }
  })
  public phones: ManyToMany<typeof Phone>

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


  // has many through relationship with merchants
  // @hasManyThrough([() => MerchantProfile, () => Account],
  //   {
  //     onQuery: (builder) => {
  //       builder.preload('address')
  //       builder.preload('phones')
  //       builder.preload('emails')
  //       builder.preload('stores')
  //     }
  //   }
  // )
  // public merchants: HasManyThrough<typeof MerchantProfile, typeof Account>

  // user has many Permissions
  // @hasMany(() => Permission, { foreignKey: 'relatedId'})
  // public permissions: HasMany<typeof Permission>

  // @afterCreate()
  // public static async createPermission(model: User) {
  //   await model.related('permissions').create({
  //     relatedType: model.constructor.name,
  //     value: "user#"+model.id+".*",
  //   })
  // }
}

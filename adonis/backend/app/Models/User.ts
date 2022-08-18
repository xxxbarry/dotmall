import { DateTime } from 'luxon'
import Hash from '@ioc:Adonis/Core/Hash'
import { column, beforeSave, ManyToMany, manyToMany, hasMany, HasMany, beforeFetch, ModelQueryBuilderContract } from '@ioc:Adonis/Lucid/Orm'
import Email from './ContactOptions/Email'
import Phone from './ContactOptions/Phone'
import DotBaseModel from '../../dot/models/DotBaseModel'
import { usePivot } from '../../dot/hooks/orm'
import Account from './Account'
import File from './File'

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

  @usePivot(() => File)
  public files: ManyToMany<typeof File>


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

  @column({ serializeAs: null })
  public password: string

  @column()
  public rememberMeToken?: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
  name: any
  description: any

  @beforeSave()
  public static async hashPassword(user: User) {
    if (user.$dirty.password) {
      user.password = await Hash.make(user.password)
    }
  }

  // beforeFetch preloads the user's accounts
  @beforeFetch()
  public static async preloadAccounts(query: ModelQueryBuilderContract<typeof User>) {
    await query.preload('accounts')
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

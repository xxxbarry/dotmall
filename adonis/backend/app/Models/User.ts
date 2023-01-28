import { DateTime } from 'luxon'
import Hash from '@ioc:Adonis/Core/Hash'
<<<<<<< HEAD
import { column, beforeSave, hasMany, HasMany, hasManyThrough, HasManyThrough, ManyToMany, manyToMany } from '@ioc:Adonis/Lucid/Orm'
import Email from './ContactOptions/Email'
import Phone from './ContactOptions/Phone'
import DotBaseModel from '../../dot/models/DotBaseModel'
import MerchantProfile from './accounts/profiles/MerchantProfile'
import { usePivot } from '../../dot/hooks/orm'
import { string } from '@ioc:Adonis/Core/Helpers'
import Account from './accounts/Account'

export enum AuthPivotTags {
  user = "auth:users"
=======
import {
  column,
  beforeSave,
  ManyToMany,
  manyToMany,
  hasMany,
  HasMany,
  beforeFetch,
  ModelQueryBuilderContract,
} from '@ioc:Adonis/Lucid/Orm'
import Email from './ContactOptions/Email'
import Phone from './ContactOptions/Phone'
import DotBaseModel from '../../dot/models/DotBaseModel'
import { usePivot } from '../../dot/hooks/orm'
import Account from './Account'
import File from './File'

export enum AuthPivotTags {
  user = 'auth:users',
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
}
export default class User extends DotBaseModel {
  public table = 'users'

<<<<<<< HEAD
  @usePivot(() => Account)
  public accounts: ManyToMany<typeof Account>
=======
  // @usePivot(() => Account)
  @hasMany(() => Account)
  public accounts: HasMany<typeof Account>
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

  @usePivot(() => Email)
  public emails: ManyToMany<typeof Email>

<<<<<<< HEAD
  @usePivot(() => Phone)
  public phones: ManyToMany<typeof Phone>

  // hasPermission(mp: ModelPermission) {
  //   var permission = this.related('permissions').where('value', mp.value).first()
  // }
=======
  @usePivot(() => File)
  public files: ManyToMany<typeof File>

  @manyToMany(() => Phone, {
    pivotForeignKey: 'related_id',
    pivotRelatedForeignKey: 'phone_id',
    pivotTable: 'phones_pivot',
    pivotColumns: ['tag'],
    onQuery: (builder) => {
      // if (tag) {
      //   builder.wherePivot('tag', tag);
      // }
    },
  })
  public phones: ManyToMany<typeof Phone>
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

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

<<<<<<< HEAD
=======
  // beforeFetch preloads the user's accounts
  @beforeFetch()
  public static async preloadAccounts(query: ModelQueryBuilderContract<typeof User>) {
    await query.preload('accounts')
  }
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

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

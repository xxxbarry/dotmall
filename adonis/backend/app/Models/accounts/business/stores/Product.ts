import { DateTime } from 'luxon'
<<<<<<< HEAD
import { BaseModel, column, hasMany, HasMany } from '@ioc:Adonis/Lucid/Orm'
=======
import {
  beforeFetch,
  BelongsTo,
  belongsTo,
  column,
  hasMany,
  HasMany,
  hasOne,
  HasOne,
  ManyToMany,
  ModelQueryBuilderContract,
} from '@ioc:Adonis/Lucid/Orm'
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
import DotBaseModel from '../../../../../dot/models/DotBaseModel'
import ProductTranslation from '../../../translations/ProductTranslation'
import { MultipartFileContract } from '@ioc:Adonis/Core/BodyParser'
import Category from 'App/Models/Category'
import { Image } from 'App/Models/File'
import Store from './Store'
import Section from './Section'
import Price from 'App/Models/Price'
import Account from 'App/Models/Account'
import { usePivot } from 'Dot/hooks/orm'

export default class Product extends DotBaseModel {
  @column()
  public name: string

  @column()
  public description: string

  @column()
  public body: string

  @column()
  public slug: string

  @column()
  public status: ProductStatus

  @column()
  public quantity: number

  @column()
  public barcode: string

  @column({
    prepare: (value: Object) => JSON.stringify(value),
    consume: (value: string) => JSON.parse(value),
  })
  public meta: Object

  @column()
  public type: ProductType

  @column()
  public storeId: string

  @column()
  public sectionId: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @column.dateTime()
  public deletedAt: DateTime

  @column.dateTime()
  public validatedAt: DateTime

  @hasMany(() => ProductTranslation)
  public translations: HasMany<typeof ProductTranslation>

  // @hasMany(() => Price)
  // public prices: HasMany<typeof Price>
  @column()
  public price: number

  @belongsTo(() => Store)
  public store: BelongsTo<typeof Store>

  @belongsTo(() => Section)
  public section: BelongsTo<typeof Section>

  @usePivot(() => Image)
  public photos: ManyToMany<typeof Image>

  // load photo after fetch
  @beforeFetch()
  public static async loadPhoto(query: ModelQueryBuilderContract<typeof Account>) {
    query.preload('photos')
  }
}

export enum ProductType {
  product = 0,
  // service="service",
}

export enum ProductStatus {
  draft = 0,
  published = 1,
  archived = 2,
  suspended = 3,
}

import { DateTime } from 'luxon'
<<<<<<< HEAD
import {  belongsTo, BelongsTo, column, hasMany, HasMany } from '@ioc:Adonis/Lucid/Orm' 
import DotBaseModel from '../../../../../dot/models/DotBaseModel'
import Store from './Store'
import SectionTranslation from 'App/Models/translations/SectionTranslation'
=======
import {
  beforeFetch,
  belongsTo,
  BelongsTo,
  column,
  hasMany,
  HasMany,
  hasOne,
  HasOne,
  ManyToMany,
  ModelQueryBuilderContract,
} from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from '../../../../../dot/models/DotBaseModel'
import Store from './Store'
import SectionTranslation from 'App/Models/translations/SectionTranslation'
import { MultipartFileContract } from '@ioc:Adonis/Core/BodyParser'
import { Image } from 'App/Models/File'
import Account from 'App/Models/Account'
import { usePivot } from 'Dot/hooks/orm'
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

export default class Section extends DotBaseModel {
  @column()
  public storeId: string

  @column()
  public categoryId: string

  @column()
  public name: string

  @column()
  public description: string

  @column()
  public slug: string

<<<<<<< HEAD

=======
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

<<<<<<< HEAD

=======
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
  @belongsTo(() => Store)
  public account: BelongsTo<typeof Store>

  @belongsTo(() => Section)
  public parent: BelongsTo<typeof Section>

  @hasMany(() => Section)
  public children: HasMany<typeof Section>

<<<<<<< HEAD

  @hasMany(() => SectionTranslation)
  public translations: HasMany<typeof SectionTranslation>
=======
  @hasMany(() => SectionTranslation)
  public translations: HasMany<typeof SectionTranslation>

  @belongsTo(() => Store)
  public store: BelongsTo<typeof Store>

  ////////////////////////////////////////////////////////////////////////////////

  @usePivot(() => Image)
  public photos: ManyToMany<typeof Image>

  // load photo after fetch
  @beforeFetch()
  public static async loadPhoto(query: ModelQueryBuilderContract<typeof Account>) {
    query.preload('photos')
  }
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
}

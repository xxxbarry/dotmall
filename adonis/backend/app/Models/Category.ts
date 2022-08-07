
import { DateTime } from 'luxon'
import { afterDelete, beforeFetch, belongsTo, BelongsTo, column, hasMany, HasMany, hasOne, HasOne, LucidModel, ManyToMany, ModelQueryBuilderContract } from '@ioc:Adonis/Lucid/Orm'
import CategoryTranslation from 'App/Models/translations/CategoryTranslation'
import DotBaseModel from 'Dot/models/DotBaseModel'
import { Image } from './File'
import { MultipartFileContract } from '@ioc:Adonis/Core/BodyParser'
import Database from '@ioc:Adonis/Lucid/Database'
import { usePivot } from 'Dot/hooks/orm'

export default class Category extends DotBaseModel {
  @column()
  public name: string

  @column()
  public description: string

  @column()
  public slug: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @belongsTo(() => Category)
  public parent: BelongsTo<typeof Category>

  @hasMany(() => Category)
  public children: HasMany<typeof Category>

  @hasMany(() => CategoryTranslation)
  public translations: HasMany<typeof CategoryTranslation>

  @usePivot(() => Image)
  public photos: ManyToMany<typeof Image>
  // load photo after fetch
  @beforeFetch()
  public static async loadPhoto(query: ModelQueryBuilderContract<typeof Category>) {
    query.preload('photos')
  }

  // delete pivot when category is deleted
  @afterDelete()
  public static async deletePivot(category: Category) {
    await Database.from('files_pivot').where('related_id', category.id).delete()
  }
}

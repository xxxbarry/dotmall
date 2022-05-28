import { DateTime } from 'luxon'
import {  belongsTo, BelongsTo, column, hasMany, HasMany } from '@ioc:Adonis/Lucid/Orm' 
import DotBaseModel from '../../../../../dot/models/DorBaseModel'
import Store from './Store'
import CategoryTranslation from 'App/Models/translations/CategoryTranslation'

export default class Category extends DotBaseModel {
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


  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime


  @belongsTo(() => Store)
  public account: BelongsTo<typeof Store>

  @belongsTo(() => Category)
  public parent: BelongsTo<typeof Category>

  @hasMany(() => Category)
  public children: HasMany<typeof Category>


  @hasMany(() => CategoryTranslation)
  public translations: HasMany<typeof CategoryTranslation>
}

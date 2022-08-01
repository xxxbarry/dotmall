import { DateTime } from 'luxon'
import { BaseModel, column, hasMany, HasMany } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from '../../../../../dot/models/DotBaseModel'
import ProductTranslation from '../../../translations/ProductTranslation'

export default class Product extends DotBaseModel {
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

  @hasMany(() => ProductTranslation)
  public translations: HasMany<typeof ProductTranslation>
}

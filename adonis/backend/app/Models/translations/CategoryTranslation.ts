
import { BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from '../../../dot/models/DotBaseModel'
import Category from '../Category'

export default class CategoryTranslation extends DotBaseModel {
  @column()
  public locale: string

  @column()
  public name: string | null

  @column()
  public description: string | null

  @column()
  public categoryId: string

  @belongsTo(() => Category)
  public category: BelongsTo<typeof Category>
}

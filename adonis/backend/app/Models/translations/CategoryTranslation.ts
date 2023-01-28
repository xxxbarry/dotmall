
import { BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
<<<<<<< HEAD
import DotBaseModel from '../../../dot/models/DotBaseModel'
import Category from '../Category'

export default class CategoryTranslation extends DotBaseModel {
  @column()
  public locale: string
=======
import { DotBaseTranslation } from '../../../dot/models/DotBaseModel'
import Category from '../Category'
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

export default class CategoryTranslation extends DotBaseTranslation {
  @column()
  public name: string | null

  @column()
  public description: string | null

  @column()
  public sectionId: string

  @belongsTo(() => Category)
  public category: BelongsTo<typeof Category>
}

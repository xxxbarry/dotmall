import { BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from '../../../dot/models/DotBaseModel'
import Section from '../accounts/business/stores/Section'

export default class SectionTranslation extends DotBaseModel {
  @column()
  public locale: string

  @column()
  public name: string | null

  @column()
  public description: string | null

  @column()
  public categoryId: string

  @belongsTo(() => Section)
  public section: BelongsTo<typeof Section>
}

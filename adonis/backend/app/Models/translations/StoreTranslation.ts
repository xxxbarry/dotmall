import { DateTime } from 'luxon'
import { BaseModel, belongsTo, BelongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel, { DotBaseTranslation } from 'Dot/models/DotBaseModel'
import Store from '../accounts/business/stores/Store'

export default class StoreTranslation extends DotBaseTranslation {
  @column()
  public name: string

  @column()
  public description: string|null

  @column()
  public storeId: string

  @belongsTo(() => Store)
  public section: BelongsTo<typeof Store>
}

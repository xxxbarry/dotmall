import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from '../../dot/models/DotBaseModel'
import User from './User'

export default class Address extends DotBaseModel {

  @column()
  public primary: string

  @column()
  public secondary: string

  @column()
  public city: string

  @column()
  public state: string

  @column()
  public zip: string

  @column()
  public country: string

  @column()
  public latitude: number

  @column()
  public longitude: number

  @column()
  public userId: string

  @belongsTo(() => User)
  public user: BelongsTo<typeof User>

  @column({ serializeAs: null })
  public relatedId: string

  @column({ serializeAs: null })
  public relatedType: string
}

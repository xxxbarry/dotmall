import { DateTime } from 'luxon'
import { BaseModel, column } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from '../../dot/models/DotBaseModel'

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
  public latitude: string

  @column()
  public longitude: string

  // @column.dateTime({ autoCreate: true })
  // public createdAt: DateTime

  // @column.dateTime({ autoCreate: true, autoUpdate: true })
  // public updatedAt: DateTime
  //
  @column({ serializeAs: null })
  public relatedId: string

  @column({ serializeAs: null })
  public relatedType: string
}

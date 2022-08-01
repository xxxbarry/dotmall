import {  column } from '@ioc:Adonis/Lucid/Orm'
import { DateTime } from 'luxon'
import DotBaseModel from '../../../dot/models/DotBaseModel'

export default class Email extends DotBaseModel {

  @column({ isPrimary: true })
  public type: string

  @column({ isPrimary: true })
  public value: string

  @column.dateTime()
  public validatedAt: DateTime

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  //
  @column({ serializeAs: null })
  public relatedId: string

  @column({ serializeAs: null })
  public relatedType: string

}

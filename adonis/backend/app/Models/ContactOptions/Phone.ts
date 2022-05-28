import {  belongsTo, BelongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import { DateTime } from 'luxon'
import User from '../User'
import DotBaseModel from 'Dot/models/DorBaseModel'

export default class Phone extends DotBaseModel {

  @column({ isPrimary: true })
  public type: string

  @column({ isPrimary: true })
  public value: string

  @column.dateTime()
  public validatedAt: DateTime

  // @column.dateTime({ autoCreate: true })
  // public createdAt: DateTime

  // @column.dateTime({ autoCreate: true, autoUpdate: true })
  // public updatedAt: DateTime
  //
  @column({ serializeAs: null })
  public relatedTo: string

  @column({ serializeAs: null })
  public relatedType: string

  @belongsTo(() => User, { foreignKey: 'relatedTo' })
  public user: BelongsTo<typeof User>

  //
  // @column()
  // public userId: string

  // belongsTo returns the [User] that owns the [ContactOption]
  // @belongsTo(() => DotBaseModel,{foreignKey:"id", localKey:"relatedTo"})
  // public owner: BelongsTo<typeof DotBaseModel>

  // static method to test if the given phone is valid
  // the given phone must match the regex pattern of phone
  public static test(phone: string): boolean {
    const pattern = /^\+?[0-9]{10,13}$/
    return pattern.test(phone)
  }
}

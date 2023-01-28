import { BaseModel, belongsTo, BelongsTo, column, ManyToMany } from '@ioc:Adonis/Lucid/Orm'
import { usedPivot } from 'Dot/hooks/orm'
import { DateTime } from 'luxon'
import DotBaseModel from '../../../dot/models/DotBaseModel'
import User from '../User'
import Phone from './Phone'

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

  @usedPivot(() => User, () => Phone)
  public users: ManyToMany<typeof User>

  //
  // @column()
  // public userId: string

  // belongsTo returns the [User] that owns the [ContactOption]
  // @belongsTo(() => User)
  // public user: BelongsTo<typeof User>

  // static method to test if the given email is valid
  // the given email must match the regex pattern of email
  // public static async test(_email: string) {
  //   const emailRegexp = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/;
  //   return emailRegexp.test(_email);
  // }
}

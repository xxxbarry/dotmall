import { DateTime } from 'luxon'
<<<<<<< HEAD
import { BaseModel, column } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from '../../dot/models/DotBaseModel'
=======
import { BaseModel, BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from '../../dot/models/DotBaseModel'
import User from './User'
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

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
<<<<<<< HEAD
  public longitude: string
=======
  public longitude: number
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

  @column()
  public userId: string

  @belongsTo(() => User)
  public user: BelongsTo<typeof User>

  @column({ serializeAs: null })
  public relatedId: string

  @column({ serializeAs: null })
  public relatedType: string
}

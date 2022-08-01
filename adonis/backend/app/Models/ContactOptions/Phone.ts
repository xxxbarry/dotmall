import {  belongsTo, BelongsTo, column, manyToMany, ManyToMany } from '@ioc:Adonis/Lucid/Orm'
import { DateTime } from 'luxon'
import DotBaseModel from 'Dot/models/DotBaseModel'
import { usedPivot } from 'Dot/hooks/orm'
import User from '../User'
import { string } from '@ioc:Adonis/Core/Helpers'

export default class Phone extends DotBaseModel {

  // @column()
  // public code: number

  @column()
  public value: string

  @column.dateTime()
  public validatedAt: DateTime

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @column({ serializeAs: null })
  public relatedId: string

  @column({ serializeAs: null })
  public relatedType: string

  @manyToMany(()=>User, {
    pivotForeignKey: 'phone_id',
    pivotRelatedForeignKey: 'related_id',
    pivotTable: "phones_pivot",
    pivotColumns: ['tag'],
    onQuery: (builder) => {
      // if (tag) {
      //   builder.wherePivot('tag', tag);
      // }
    }
  })
  public users: ManyToMany<typeof User>

  //
  // @column()
  // public userId: string

  // belongsTo returns the [User] that owns the [ContactOption]
  // @belongsTo(() => DotBaseModel,{foreignKey:"id", localKey:"relatedId"})
  // public owner: BelongsTo<typeof DotBaseModel>

  // static method to test if the given phone is valid
  // the given phone must match the regex pattern of phone
  public static test(phone: string): boolean {
    const pattern = /^\+?[0-9]{10,13}$/
    return pattern.test(phone)
  }
}

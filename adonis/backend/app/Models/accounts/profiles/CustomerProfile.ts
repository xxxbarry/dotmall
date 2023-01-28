import { column, hasOne, HasOne, belongsTo, BelongsTo, HasMany, hasMany } from '@ioc:Adonis/Lucid/Orm'
import Account from 'App/Models/Account'
import Address from 'App/Models/Address'
import Email from 'App/Models/ContactOptions/Email'
import Phone from 'App/Models/ContactOptions/Phone'
import DotBaseModel from 'Dot/models/DotBaseModel'
import { DateTime } from 'luxon'
import { HumanGender, ProfileModel } from './Profile'


<<<<<<< HEAD
export default class CustomerProfile extends ProfileModel {
=======
export default class CustomerProfile extends DotBaseModel {

  @column()
  public relatedId: string

  @hasMany(() => Email, {
      foreignKey: "relatedId",
      onQuery: (builder) => {
          builder.where('related_type', 'profiles:emails')
      }
  })
  public emails: HasMany<typeof Email>

  @hasMany(() => Phone, {
      foreignKey: "relatedId",
      onQuery: (builder) => {
          builder.where('related_type', 'profiles:phones')
      }
  })
  public phones: HasMany<typeof Phone>

>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
    @hasMany(() => Address, { foreignKey: 'relatedId' })
    public addresses: HasMany<typeof Address>

    @column()
    public accountId: string

    @belongsTo(() => Account)
    public account: BelongsTo<typeof Account>
}

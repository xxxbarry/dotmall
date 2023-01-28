import { column, hasOne, HasOne, belongsTo, BelongsTo, HasMany, hasMany } from '@ioc:Adonis/Lucid/Orm'
import Account from 'App/Models/Account'
import Address from 'App/Models/Address'
import Email from 'App/Models/ContactOptions/Email'
import Phone from 'App/Models/ContactOptions/Phone'
import DotBaseModel from 'Dot/models/DotBaseModel'
import { DateTime } from 'luxon'
import { HumanGender, ProfileModel } from './Profile'


export default class CustomerProfile extends ProfileModel {
    @hasMany(() => Address, { foreignKey: 'relatedId' })
    public addresses: HasMany<typeof Address>

    @column()
    public accountId: string

    @belongsTo(() => Account)
    public account: BelongsTo<typeof Account>
}

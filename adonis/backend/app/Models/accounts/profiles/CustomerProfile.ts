import { column, hasOne, HasOne, belongsTo, BelongsTo, HasMany, hasMany } from '@ioc:Adonis/Lucid/Orm'
import Address from 'App/Models/Address'
import Email from 'App/Models/ContactOptions/Email'
import Phone from 'App/Models/ContactOptions/Phone'
import DotBaseModel from 'Dot/models/DorBaseModel'
import { DateTime } from 'luxon'
import Account from '../Account'
import { HumanGender, ProfileModel } from './Profile'


export default class CustomerProfile extends ProfileModel {
    @hasMany(() => Address, { foreignKey: 'relatedTo' })
    public addresses: HasMany<typeof Address>

    @column()
    public accountId: string

    @belongsTo(() => Account)
    public account: BelongsTo<typeof Account>
}

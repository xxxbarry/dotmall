import Email from '../../ContactOptions/Email'
import Phone from '../../ContactOptions/Phone'
<<<<<<< HEAD
import Address from '../../Address'
import DotBaseModel from 'Dot/models/DotBaseModel'
=======
import DotBaseModel from 'Dot/models/DotBaseModel'
import { column, hasMany, HasMany } from '@ioc:Adonis/Lucid/Orm'
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

export enum HumanGender {
    male = 0,
    female = 1,
}
export class ProfileModel extends DotBaseModel  {
<<<<<<< HEAD
    // @column.dateTime({ autoCreate: true })
    // public createdAt: DateTime
    // @column.dateTime({ autoCreate: true, autoUpdate: true })
    // public updatedAt: DateTime
    @column()
    public relatedId: string
    // has address

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
=======
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
}


// export default class Project extends compose(DotBaseModel, ProfileMixin) {

// }


// export default class Profile {
//     public fullname: string
//     public gender: HumanGender
//     public createdAt: DateTime
//     public updatedAt: DateTime
//     public relatedId: string
//     public address: HasOne<typeof Address>
//     public email: HasOne<typeof Email>
//     public phone: HasOne<typeof Phone>
//     public account: BelongsTo<typeof Account>
// }


// create class HasManyByLanguage extends HasMany and override the query builder
// to filter by language

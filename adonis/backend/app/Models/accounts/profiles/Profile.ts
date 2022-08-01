import Email from '../../ContactOptions/Email'
import Phone from '../../ContactOptions/Phone'
import DotBaseModel from 'Dot/models/DotBaseModel'
import { column, hasMany, HasMany } from '@ioc:Adonis/Lucid/Orm'

export enum HumanGender {
    male = 0,
    female = 1,
}
export class ProfileModel extends DotBaseModel  {
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

// import { DateTime } from 'luxon'
// import { BaseModel, belongsTo, BelongsTo, column, hasOne, HasOne } from '@ioc:Adonis/Lucid/Orm'
// import Account, { AccountData } from './Account'
// import DotBaseModel from '../../../dot/models/DorBaseModel'
// import CustomerProfile from './profiles/CustomerProfile'
// import MerchantProfile from './profiles/MerchantProfile'

import { AccountData } from "./Account";

// export default class PersonalAccountData extends AccountData {

//     @column()
//     public name: string

//     @belongsTo(() => Account)
//     public account: BelongsTo<typeof Account>
// }

export class PersonalAccountData extends AccountData {
    fullname: string
    age: number
    constructor(data: PersonalAccountData) {
        super(data);
    }
}


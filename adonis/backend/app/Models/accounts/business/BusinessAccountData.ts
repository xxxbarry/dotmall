// import { DateTime } from 'luxon'
// import {  belongsTo, BelongsTo, column, hasOne, HasOne } from '@ioc:Adonis/Lucid/Orm'
// import Account, { AccountData } from '../Account'
// import DotBaseModel from '../../../../dot/models/DorBaseModel'
// import { HumanGender } from '../profiles/Profile'

import { AccountData } from "../Account";

// export default class BusinessAccountData extends AccountData {

//   @column()
//   public fullname: string

//   @column()
//   public gender: HumanGender

//   @column()
//   public birthday: DateTime

//   @belongsTo(() => Account)
//   public account: BelongsTo<typeof Account>
// }
export class BusinessAccountData extends AccountData {
  name: string
  constructor(data: BusinessAccountData) {
    super(data);
  }
}
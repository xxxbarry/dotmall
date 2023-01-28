// import { DateTime } from 'luxon'
// import {  belongsTo, BelongsTo, column, hasOne, HasOne } from '@ioc:Adonis/Lucid/Orm'
// import DotBaseModel from '../../../../dot/models/DorBaseModel'
// import { HumanGender } from '../profiles/Profile'

import { AccountData } from "App/Models/Account";


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
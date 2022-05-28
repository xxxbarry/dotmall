// import { BaseModel, beforeCreate, beforeSave, column } from "@ioc:Adonis/Lucid/Orm";
// import DotBaseSchema from "dot/DotBaseSchema";
// import { v4 as uuidv4 } from 'uuid';
// export default class DotUUIDInterface extends BaseModel {
//     @column({ isPrimary: true })
//     public id: string

//     @beforeCreate()
//     public static async createUuid(model: DotUUIDInterface) {
//         var uuidToken = uuidv4()
//         model.id = uuidToken
//     }
// }
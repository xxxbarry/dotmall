import { BaseModel, beforeCreate, column, LucidModel } from "@ioc:Adonis/Lucid/Orm";
import {customAlphabet} from 'nanoid';
import DotValidator from "App/Validators/DotValidator";
import { validator } from '@ioc:Adonis/Core/Validator'
const alphabet = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnoprstuvwxyz';
const nanoid = customAlphabet(alphabet, 14);
export default class DotBaseModel/*<T extends LucidModel>*/ extends BaseModel {
    @column({ isPrimary: true })
    public id: string


    /**
     * Before create, generate id for the model
     * @param model 
     * @returns {Promise<void>}
     */
    @beforeCreate()
    public static async createId(model: DotBaseModel): Promise<void> {
        if (!model.id) {
            model.id = nanoid()
        }
    }

    /**
     * Generates id for the model
     * @returns {string}
     */
    public static  generateId(): string {
        return nanoid()
    }

    /**
     * Uploads path
     * for all Models extand this class, you can use this getter to define the path of the file
     * @returns {string}
     * @memberof DotBaseModel
     * @returnExample '/uploads/{table_name}/{current_year}'
     * @returnExample '/uploads/{table_name}/{current_year}/{subPath}'
     */
    public static uploadPath(subPath: String|null = null): string {
        var path = `/uploads/${this.table}/${new Date().getFullYear()}`
        if (subPath) {
            path += `/${subPath}`
        }
        return path
    }

    
}


// export class DotBaseModelWithPermission extends DotBaseModel {

//     // hasMany
//     @hasMany(() => Permission, {foreignKey: 'relatedTo'})
//     public permissions: HasMany<typeof Permission>

//     @afterCreate()
//     public static async createPermission(model: DotBaseModelWithPermission) {
//         model.related("permissions").create({
//             relatedType: model.constructor.name,
//             actions: ['all']
//         })
//     }
// }

// export function ProfileMixin<T extends NormalizeConstructor<LucidModel>>(superclass: T) {
//     class AProfileModel extends superclass {

//         @column.dateTime({ autoCreate: true })
//         public createdAt: DateTime

//         @column.dateTime({ autoCreate: true, autoUpdate: true })
//         public updatedAt: DateTime

//         @column()
//         public relatedTo: string
//         // has address
//         @hasOne(() => Address, { foreignKey: 'relatedTo' })
//         public address: HasOne<typeof Address>

//         @hasOne(() => Email, { foreignKey: 'relatedTo' })
//         public email: HasOne<typeof Email>

//         @hasOne(() => Phone, { foreignKey: 'relatedTo' })
//         public phone: HasOne<typeof Phone>

//         @belongsTo(() => Account)
//         public account: BelongsTo<typeof Account>

//     }

//     return AProfileModel;
// }
// export function ProfileMixin<T extends NormalizeConstructor<LucidModel>>(superclass: T) {
//     class AProfileModel extends superclass {

//         @column.dateTime({ autoCreate: true })
//         public createdAt: DateTime

//         @column.dateTime({ autoCreate: true, autoUpdate: true })
//         public updatedAt: DateTime

//         @column()
//         public relatedTo: string
//         // has address
//         @hasOne(() => Address, { foreignKey: 'relatedTo' })
//         public address: HasOne<typeof Address>

//         @hasOne(() => Email, { foreignKey: 'relatedTo' })
//         public email: HasOne<typeof Email>

//         @hasOne(() => Phone, { foreignKey: 'relatedTo' })
//         public phone: HasOne<typeof Phone>

//         @belongsTo(() => Account)
//         public account: BelongsTo<typeof Account>

//     }

//     return AProfileModel;
// }
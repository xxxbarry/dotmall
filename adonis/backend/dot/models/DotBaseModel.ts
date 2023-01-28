<<<<<<< HEAD
import { BaseModel, beforeCreate, column, ExtractModelRelations, LucidModel, ModelRelations } from "@ioc:Adonis/Lucid/Orm";
import {customAlphabet} from 'nanoid';
import { MultipartFileContract } from '@ioc:Adonis/Core/BodyParser'
import { Image } from "App/Models/File";
=======
import { BaseModel, beforeCreate, column } from "@ioc:Adonis/Lucid/Orm";
import {customAlphabet} from 'nanoid';
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

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
    public static uploadPath(options: UploadPathOptions = {}): string {
        var path = `/uploads/${options.folder??this.table}`
        if (options.wrapOnYear) {
            path += `/${new Date().getFullYear()}`
        }
        if (options.subPath) {
            path += `/${options.subPath}`
        }
        return path
    }


  // async pivot<Name extends ExtractModelRelations<this>>(relation: Name): Promise<this[Name] extends ModelRelations ? any : never> {

  //   return await this.related(relation).attach({
  //     [email.id]: {
  //       id: "",
  //       tag: "primary"
  //     }
  //   });
  // }


}

export class UploadPathOptions {
    public subPath?: String|null = null
    public folder?: String|null = null
    public wrapOnYear?: Boolean = true
}
// export class DotBaseModelWithPermission extends DotBaseModel {

//     // hasMany
//     @hasMany(() => Permission, {foreignKey: 'relatedId'})
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
//         public relatedId: string
//         // has address
//         @hasOne(() => Address, { foreignKey: 'relatedId' })
//         public address: HasOne<typeof Address>

//         @hasOne(() => Email, { foreignKey: 'relatedId' })
//         public email: HasOne<typeof Email>

//         @hasOne(() => Phone, { foreignKey: 'relatedId' })
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
//         public relatedId: string
//         // has address
//         @hasOne(() => Address, { foreignKey: 'relatedId' })
//         public address: HasOne<typeof Address>

//         @hasOne(() => Email, { foreignKey: 'relatedId' })
//         public email: HasOne<typeof Email>

//         @hasOne(() => Phone, { foreignKey: 'relatedId' })
//         public phone: HasOne<typeof Phone>

//         @belongsTo(() => Account)
//         public account: BelongsTo<typeof Account>

//     }

//     return AProfileModel;
// }
<<<<<<< HEAD
=======

export class DotBaseTranslation extends DotBaseModel {
    @column()
    public locale: string
}
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

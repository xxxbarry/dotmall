import { DateTime } from 'luxon'
import { afterDelete, BaseModel, beforeFetch, beforeSave, column, LucidModel, ModelAssignOptions, ModelAttributes, ModelQueryBuilderContract } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from '../../dot/models/DorBaseModel'
import Drive from '@ioc:Adonis/Core/Drive'
import Application from '@ioc:Adonis/Core/Application'
import { MultipartFileContract } from '@ioc:Adonis/Core/BodyParser'

export default class File extends DotBaseModel {

  @column({ isPrimary: true })
  public id: string

  @column()
  public name: string|null

  @column()
  public description: string|null

  @column()
  public path: string|null

  @column()
  public mime: string|null

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @column({ serializeAs: null })
  public relatedTo: string

  @column({ serializeAs: null })
  public relatedType: string


  // before delete, delete file if it exists
  @afterDelete()
  public static async deleteAvatar(instance: File) {
    if (instance.path) {
      await Drive.delete(Application.publicPath(instance.path))
    }
  }


  // static method to handle the avatar upload
  public static async upload(multipartFile: MultipartFileContract, path: string, name: string): Promise<string> {
    // move file to storege
    await multipartFile.move(Application.publicPath(path), {
      name: `${name}.${multipartFile.extname}`,
    })
    return path + `${name}.${multipartFile.extname}`
  }

  // public static async uploadAndCreates<T extends LucidModel>(this: T, values: Partial<ModelAttributes<InstanceType<T>>>, options?: ModelAssignOptions): Promise<InstanceType<T>>{
    
  // }

  // uploadAndCreate
  public static async uploadAndCreate<T extends File>(fileUploadData: _FileUploadData): Promise<T> {
    var fileId = fileUploadData.id ?? DotBaseModel.generateId()
    var uploadPath = fileUploadData.relatedType?.uploadPath() ?? File.uploadPath()
    // move file to storege
    var path = await File.upload(fileUploadData.multipartFile, uploadPath, fileUploadData.name ?? fileId)
    return await File.create({
      id: fileId,
      path: path,
      name: fileUploadData.name,
      relatedTo: fileUploadData.relatedTo,
      relatedType: fileUploadData.relatedType?.table,
    }) as T
  }

  
}
// _FileAndUploadType
class _FileUploadData  {
  multipartFile: MultipartFileContract
  id?: string|null
  name?: string|null
  relatedTo?: string
  relatedType?:typeof DotBaseModel
}
export class Image extends File {
  public static table = 'files'

  @column()
  public path: string

  // @beforeSave()
  // public static async setRelatedType(image: Image) {
  //   image.relatedType = this.name
  // }
  // @beforeFetch()
  // public static onlyType(query: ModelQueryBuilderContract<typeof Image>) {
  //   query.where('related_type', this.name)
  // }

}
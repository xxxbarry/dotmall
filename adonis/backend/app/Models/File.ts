import { DateTime } from 'luxon'
<<<<<<< HEAD
import { afterDelete, BaseModel, beforeFetch, beforeSave, column, LucidModel, ModelAssignOptions, ModelAttributes, ModelQueryBuilderContract } from '@ioc:Adonis/Lucid/Orm'
=======
import { afterDelete, column } from '@ioc:Adonis/Lucid/Orm'
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
import DotBaseModel from '../../dot/models/DotBaseModel'
import Drive from '@ioc:Adonis/Core/Drive'
import Application from '@ioc:Adonis/Core/Application'
import { MultipartFileContract } from '@ioc:Adonis/Core/BodyParser'
import Database from '@ioc:Adonis/Lucid/Database'

export default class File extends DotBaseModel {
<<<<<<< HEAD


=======
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
  @column({ isPrimary: true })
  public id: string

  @column()
  public name: string | null

  @column()
  public description: string | null

  @column()
  public path: string | null

  @column()
  public mime: string | null

  @column()
  public userId: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @column({ serializeAs: null })
  public relatedId: string

  @column({ serializeAs: null })
  public relatedType: string

  ////////// RELATED MODELS //////////
  // @manyToMany(()=>Account, {
  //   pivotForeignKey: 'file_id',
  //   pivotRelatedForeignKey: 'related_id',
  //   pivotTable: "files_pivot",
  //   pivotColumns: ['tag'],
  //   onQuery: (builder) => {
  //     // if (tag) {
  //     //   builder.wherePivot('tag', tag);
  //     // }
  //   }
  // })
  // public accounts: ManyToMany<typeof Account>

  // before delete, delete file if it exists
  @afterDelete()
  public static async deletePhoto(instance: File) {
    if (instance.path) {
      await Drive.delete(Application.publicPath(instance.path))
    }
  }

<<<<<<< HEAD

  // static method to handle the photo upload
  public static async upload(multipartFile: MultipartFileContract, path: string, name: string): Promise<string> {
=======
  // static method to handle the photo upload
  public static async upload(
    multipartFile: MultipartFileContract,
    path: string,
    name: string
  ): Promise<string> {
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
    // move file to storege
    await multipartFile.move(Application.publicPath(path), {
      name: `${name}.${multipartFile.extname}`,
    })
    return path + `/${name}.${multipartFile.extname}`
  }

  // public static async uploadAndCreates<T extends LucidModel>(this: T, values: Partial<ModelAttributes<InstanceType<T>>>, options?: ModelAssignOptions): Promise<InstanceType<T>>{

  // }

  // uploadAndCreate
  public static async uploadAndCreate<T extends File>(fileUploadData: _FileUploadData): Promise<T> {
    var fileId = fileUploadData.id ?? DotBaseModel.generateId()
    var uploadPath = File.uploadPath()
<<<<<<< HEAD
    // if (typeof fileUploadData.relatedType === 'string') {
    //   uploadPath = File.uploadPath({
    //     folder: fileUploadData.relatedType,
    //   })
    // } else if (typeof fileUploadData.relatedType === 'object') {
    //   uploadPath = File.uploadPath({
    //     folder: (fileUploadData.relatedType as LucidModel).table,
    //   })
    // }
    // move file to storege
    var path = await File.upload(fileUploadData.multipartFile, uploadPath, fileUploadData.name ?? fileId)
    return await File.create({
      id: fileId,
      path: path,
      name: fileUploadData.name,
      relatedId: fileUploadData.relatedId,
      relatedType: typeof fileUploadData.relatedType === 'string' ? fileUploadData.relatedType : fileUploadData.relatedType?.table,
    }) as T
  }


=======
    var path = await File.upload(
      fileUploadData.multipartFile,
      uploadPath,
      fileUploadData.name ?? fileId
    )
    var file = (await File.create({
      id: fileId,
      path: path,
      name: fileUploadData.name,
      userId: fileUploadData.user_id,
    })) as T
    await Database.table('files_pivot').insert({
      id: DotBaseModel.generateId(),
      file_id: file.id,
      related_id: fileUploadData.relatedId,
      tag: fileUploadData.tag,
    })
    return file
  }

  /**
   * attach file from MultipartFile
   * @param {MultipartFileContract} file
   * @param {boolean} [deleteOld=false]
   * @param {string} [tag='file']
   * @returns {Promise<Image>}
   */
  static async attachModel<T extends File>(options: {
    related_id: string
    file: MultipartFileContract
    deleteOld?: boolean
    tag: string
    user_id: string
  }): Promise<T> {
    var file = await File.uploadAndCreate<T>({
      multipartFile: options.file,
      tag: options.tag,
      relatedId: options.related_id,
      user_id: options.user_id,
    })
    if (options.deleteOld && file) {
      var files_pivot = await Database.from('files_pivot')
        .where('related_id', options.related_id)
        .whereNot('file_id', file.id)
        .where('tag', options.tag)
      files_pivot.forEach(
        async (file_pivot) => await (await File.find(file_pivot.file_id))?.delete()
      )
    }
    return file
  }
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
}
// _FileAndUploadType
class _FileUploadData {
  multipartFile: MultipartFileContract
<<<<<<< HEAD
  id?: string|null
  name?: string|null
  relatedId?: string
  relatedType?:typeof DotBaseModel|string
=======
  id?: string | null
  name?: string | null
  relatedId?: string
  relatedType?: typeof DotBaseModel | string
  tag?: string | null
  user_id: string
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
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

<<<<<<< HEAD
=======
  // static async setPhotoToModel(image: MultipartFileContract,table:string, tag: string, deleteOld: boolean = true): Promise<Image> {
  //   var photo = await Image.uploadAndCreate<Image>({
  //     multipartFile: image,
  //     tag: tag
  //   })
  //   if (deleteOld && photo) {
  //     var currentPhoto = await Image.query().where('related_type', tag).where('related_id', this.id).first()
  //     if (currentPhoto)
  //       await currentPhoto.delete()
  //   }
  //   return photo
  // }
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
}

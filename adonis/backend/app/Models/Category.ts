
import { DateTime } from 'luxon'
<<<<<<< HEAD
import { beforeFetch, belongsTo, BelongsTo, column, hasMany, HasMany, hasOne, HasOne, LucidModel, ModelQueryBuilderContract } from '@ioc:Adonis/Lucid/Orm'
=======
import { afterDelete, beforeFetch, belongsTo, BelongsTo, column, hasMany, HasMany, hasOne, HasOne, LucidModel, ManyToMany, ModelQueryBuilderContract } from '@ioc:Adonis/Lucid/Orm'
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
import CategoryTranslation from 'App/Models/translations/CategoryTranslation'
import DotBaseModel from 'Dot/models/DotBaseModel'
import { Image } from './File'
import { MultipartFileContract } from '@ioc:Adonis/Core/BodyParser'
<<<<<<< HEAD
import Account from './accounts/Account'
=======
import Database from '@ioc:Adonis/Lucid/Database'
import { usePivot } from 'Dot/hooks/orm'
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

export default class Category extends DotBaseModel {
  @column()
  public name: string

  @column()
  public description: string

  @column()
  public slug: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @belongsTo(() => Category)
  public parent: BelongsTo<typeof Category>

  @hasMany(() => Category)
  public children: HasMany<typeof Category>

  @hasMany(() => CategoryTranslation)
  public translations: HasMany<typeof CategoryTranslation>

<<<<<<< HEAD

  @hasOne(() => Image, { foreignKey: "relatedId",
    onQuery: (builder) => {
      builder.where('related_type', 'categories:photo')
    }
  })
  public photo: HasOne<typeof Image>
  // load photo after fetch
  @beforeFetch()
  public static async loadPhoto(query: ModelQueryBuilderContract<typeof Category>) {
    query.preload('photo')
  }

  /**
   * set photo from MultipartFile
   * @param {MultipartFileContract} image
   * @param {boolean} [deleteOld=false]
   * @returns {Promise<Image>}
   */
  public async setPhoto(image: MultipartFileContract, deleteOld: boolean = true): Promise<Image> {
    var currentPhoto = await Image.query().where('related_type', 'categories:photo').where('related_id', this.id).first()
    var photo = await Image.uploadAndCreate<Image>({
      multipartFile: image,
      relatedId: this.id,
      relatedType: Category,
    })
    if (deleteOld && photo && currentPhoto) {
      await currentPhoto.delete()
    }
    return photo
=======
  @usePivot(() => Image)
  public photos: ManyToMany<typeof Image>
  // load photo after fetch
  @beforeFetch()
  public static async loadPhoto(query: ModelQueryBuilderContract<typeof Category>) {
    query.preload('photos')
  }

  // delete pivot when category is deleted
  @afterDelete()
  public static async deletePivot(category: Category) {
    await Database.from('files_pivot').where('related_id', category.id).delete()
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
  }
}

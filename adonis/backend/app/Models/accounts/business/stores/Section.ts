import { DateTime } from 'luxon'
import {  beforeFetch, belongsTo, BelongsTo, column, hasMany, HasMany, hasOne, HasOne, ModelQueryBuilderContract } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from '../../../../../dot/models/DotBaseModel'
import Store from './Store'
import SectionTranslation from 'App/Models/translations/SectionTranslation'
import { MultipartFileContract } from '@ioc:Adonis/Core/BodyParser'
import { Image } from 'App/Models/File'


export default class Section extends DotBaseModel {
  @column()
  public storeId: string

  @column()
  public categoryId: string

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

  @belongsTo(() => Store)
  public account: BelongsTo<typeof Store>

  @belongsTo(() => Section)
  public parent: BelongsTo<typeof Section>

  @hasMany(() => Section)
  public children: HasMany<typeof Section>

  @hasMany(() => SectionTranslation)
  public translations: HasMany<typeof SectionTranslation>

  @belongsTo(() => Store)
  public store: BelongsTo<typeof Store>

  ////////////////////////////////////////////////////////////////////////////////
  @hasOne(() => Image, { foreignKey: "relatedId",
    onQuery: (builder) => {
      builder.where('related_type', 'sections:photo')
    }
  })
  public photo: HasOne<typeof Image>
  // load photo after fetch
  @beforeFetch()
  public static async loadPhoto(query: ModelQueryBuilderContract<typeof Section>) {
    query.preload('photo')
  }

  /**
   * set photo from MultipartFile
   * @param {MultipartFileContract} image
   * @param {boolean} [deleteOld=false]
   * @returns {Promise<Image>}
   */
  public async setPhoto(image: MultipartFileContract, deleteOld: boolean = true): Promise<Image> {
    var currentPhoto = await Image.query().where('related_type', 'sections:photo').where('related_id', this.id).first()
    var photo = await Image.uploadAndCreate<Image>({
      multipartFile: image,
      relatedId: this.id,
      relatedType: Section,
    })
    if (deleteOld && photo && currentPhoto) {
      await currentPhoto.delete()
    }
    return photo
  }
}

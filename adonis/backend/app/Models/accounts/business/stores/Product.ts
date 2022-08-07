import { DateTime } from 'luxon'
import { beforeFetch, BelongsTo, belongsTo, column, hasMany, HasMany, hasOne, HasOne, ModelQueryBuilderContract } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from '../../../../../dot/models/DotBaseModel'
import ProductTranslation from '../../../translations/ProductTranslation'
import { MultipartFileContract } from '@ioc:Adonis/Core/BodyParser'
import Category from 'App/Models/Category'
import { Image } from 'App/Models/File'
import Store from './Store'
import Section from './Section'
import Price from 'App/Models/Price'

export default class Product extends DotBaseModel {

  @column()
  public name: string

  @column()
  public description: string

  @column()
  public body: string

  @column()
  public slug: string

  @column()
  public barcode: string

  @column({
    prepare: (value: Object) => JSON.stringify(value),
    consume: (value: string) => JSON.parse(value),
  })
  public meta: Object

  @column()
  public product_type: string

  @column()
  public storeId: string

  @column()
  public sectionId: string

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @hasMany(() => ProductTranslation)
  public translations: HasMany<typeof ProductTranslation>

  // @hasMany(() => Price)
  // public prices: HasMany<typeof Price>
  @column()
  public price: number

  @belongsTo(() => Store)
  public store: BelongsTo<typeof Store>

  @belongsTo(() => Section)
  public section: BelongsTo<typeof Section>

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
    var currentPhoto = await Image.query().where('related_type', 'products:photo').where('related_id', this.id).first()
    var photo = await Image.uploadAndCreate<Image>({
      multipartFile: image,
      relatedId: this.id,
      relatedType: Category,
    })
    if (deleteOld && photo && currentPhoto) {
      await currentPhoto.delete()
    }
    return photo
  }
}

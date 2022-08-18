import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { CreateProductTranslationValidator, DestroyProductTranslationValidator, ListProductTranslationsValidator, ShowProductTranslationValidator, UpdateProductTranslationValidator } from 'App/Validators/ProductTranslationValidator'
import { ModelObject } from '@ioc:Adonis/Lucid/Orm';
import ProductTranslation from 'App/Models/translations/ProductTranslation';

export default class ProductTranslationsController {
  /**
    * returns the user's productTranslations as pangination list
    * @param {HttpContextContract}
    * @returns {Promise<{meta: any;data: ModelObject[];}>}
    * @memberof ProductTranslationsController
    * @example
    * curl -X GET -H "Content-Type: application/json" -d '{"page": 1}' http://localhost:3333/api/v1/productTranslations
    */
  public async index({ request, bouncer }: HttpContextContract) {

    const payload = await request.validate(ListProductTranslationsValidator)
    await bouncer.with('ProductTranslationPolicy').authorize('viewList', payload)
    var productTranslationsQuery = ProductTranslation.query()
    var page = 1
    var limit = 12

    if (payload.search) {
      for (let i = 0; i < payload.search_in!.length; i++) {
        const element = payload.search_in![i];
        if (i == 0) {
          productTranslationsQuery = productTranslationsQuery.where(element, 'like', `%${payload.search}%`)
        } else {
          productTranslationsQuery = productTranslationsQuery.orWhere(element, 'like', `%${payload.search}%`)
        }
      }
    }
    if (payload.sort) {
      productTranslationsQuery = productTranslationsQuery.orderBy(payload.sort, payload.order)
    }
    if (payload.load) {
      for (const load of payload.load) {
        productTranslationsQuery = productTranslationsQuery.preload(load)
      }
    }
    if (payload.where) {
      for (const key in payload.where) {
        productTranslationsQuery = productTranslationsQuery.where(key, payload.where[key])
      }
    }
    page = payload.page || page
    limit = payload.limit || limit

    return (await productTranslationsQuery.paginate(page, Math.min(limit, 24))).toJSON()
  }

  /**
   * creates a new productTranslation for the user
   * @param {HttpContextContract}
   * @returns {Promise<{ productTranslation: ModelObject; photo: Image | null; }>}
   * @memberof ProductTranslationsController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My ProductTranslation", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/productTranslations
   */
  public async store({ request, bouncer }: HttpContextContract): Promise<{ productTranslation: ModelObject }> {

    const payload = await request.validate(CreateProductTranslationValidator)
    await bouncer.with('ProductTranslationPolicy').authorize('create', null)
    const productTranslation = await ProductTranslation.create({
      locale: payload.locale,
      name: payload.name,
      description: payload.description,
      slug: payload.slug,
      body: payload.body,
      productId: payload.product_id,
    })
    return {
      productTranslation: productTranslation.toJSON()
    }
  }

  /**
   * returns the productTranslation info
   * @param {HttpContextContract}
   * @returns {Promise<ProductTranslation>}
   * @memberof ProductTranslationsController
   * @example
   * curl -X GET -H "Content-Type: application/json" http://localhost:3333/api/v1/productTranslations/1
   */
  public async show({ request, bouncer }: HttpContextContract): Promise<any> {
    const payload = await request.validate(ShowProductTranslationValidator)
    var productTranslation = (await ProductTranslation.find(payload.params.id))!
    await bouncer.with('ProductTranslationPolicy').authorize('view', productTranslation)
    if (payload.load) {
      for (const load of payload.load) {
        await productTranslation.load(load)
      }
    }
    return productTranslation.toJSON()
  }

  /**
   * updates the productTranslation info
   * @param {HttpContextContract}
   * @returns {Promise<ProductTranslation>}
   * @memberof ProductTranslationsController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My ProductTranslation", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/productTranslations/1
   */
  public async update({ request, bouncer }: HttpContextContract): Promise<{
    productTranslation: ModelObject;
  }> {
    // validate also params.id
    const payload = await request.validate(UpdateProductTranslationValidator)
    const productTranslation = (await ProductTranslation.find(payload.params.id))!
    await bouncer.with('ProductTranslationPolicy').authorize('update', productTranslation)
    productTranslation.name = payload.name ?? productTranslation.name
    productTranslation.description = payload.description ?? productTranslation.description
    productTranslation.locale = payload.locale ?? productTranslation.locale
    productTranslation.slug = payload.slug ?? productTranslation.slug
    productTranslation.body = payload.body ?? productTranslation.body
    await productTranslation.save()
    return {
      productTranslation: productTranslation.toJSON(),
    }
  }

  /**
   * deletes the productTranslation
   * @param {HttpContextContract}
   * @returns {Promise<void>}
   * @memberof ProductTranslationsController
   * @example
   * curl -X DELETE -H "Content-Type: application/json" http://localhost:3333/api/v1/productTranslations/{productTranslationId}
   */
  public async destroy({ request, bouncer }: HttpContextContract): Promise<void> {
    const payload = await request.validate(DestroyProductTranslationValidator)
    const productTranslation = (await ProductTranslation.find(payload.params.id))!
    await bouncer.with('ProductTranslationPolicy').authorize('delete', productTranslation)
    return await productTranslation.delete()
  }


}

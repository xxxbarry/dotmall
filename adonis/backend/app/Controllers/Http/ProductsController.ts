import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { Image } from 'App/Models/File'
import { ModelObject } from '@ioc:Adonis/Lucid/Orm';
import Product from 'App/Models/accounts/business/stores/Product';
import  { CreateProductValidator, DestroyProductValidator, ListProductsValidator, ShowProductValidator, UpdateProductValidator } from 'App/Validators/ProductValidator'

export default class ProductsController {
  /**
    * returns the user's products as pangination list
    * @param {HttpContextContract}
    * @returns {Promise<{meta: any;data: ModelObject[];}>}
    * @memberof ProductsController
    * @example
    * curl -X GET -H "Content-Type: application/json" -d '{"page": 1}' http://localhost:3333/api/v1/products
    */
  public async index({ request, bouncer }: HttpContextContract): Promise<{
    meta: any;
    data: ModelObject[];
  }> {
    const payload = await request.validate(ListProductsValidator)
    await bouncer.with('ProductPolicy').authorize('viewList', payload)
    var productsQuery = Product.query()
    var page = 1
    var limit = 24

    if (payload.search) {
      for (let i = 0; i < payload.search_in!.length; i++) {
        const element = payload.search_in![i];
        if (i == 0) {
          productsQuery = productsQuery.where(element, 'like', `%${payload.search}%`)
        } else {
          productsQuery = productsQuery.orWhere(element, 'like', `%${payload.search}%`)
        }
      }
    }
    if (payload.sort) {
      productsQuery = productsQuery.orderBy(payload.sort, payload.order)
    }
    if (payload.load) {
      for (const load of payload.load) {
        productsQuery = productsQuery.preload(load)
      }
    }
    if (payload.where) {
      for (const key in payload.where) {
        productsQuery = productsQuery.where(key, payload.where[key])
      }
    }
    page = payload.page || page
    limit = payload.limit || limit

    return (await productsQuery.paginate(page, Math.min(limit, 24))).toJSON()
  }

  /**
   * creates a new product for the user
   * @param {HttpContextContract}
   * @returns {Promise<{ product: ModelObject; photo: Image | null; }>}
   * @memberof ProductsController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Product", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/products
   */
  public async store({ request, bouncer }: HttpContextContract): Promise<{ product: ModelObject; photo: Image | null; }> {

    await bouncer.with('ProductPolicy').authorize('create', null)
    const payload = await request.validate(CreateProductValidator)
    const product = await Product.create({
      name: payload.name,
      description: payload.description,
      storeId: payload.store_id,
      sectionId: payload.section_id,
      product_type: payload.product_type,
      barcode: payload.barcode,
      price: payload.price,
      body: payload.body,
      meta: payload.meta,
      slug: payload.slug,
    })
    var photo: Image | null = null;
    if (payload.photo) {
      photo = await product.setPhoto(payload.photo)
    }
    return {
      product: product.toJSON(),
      photo: photo,
    }
  }

  /**
   * returns the product info
   * @param {HttpContextContract}
   * @returns {Promise<Product>}
   * @memberof ProductsController
   * @example
   * curl -X GET -H "Content-Type: application/json" http://localhost:3333/api/v1/products/1
   */
  public async show({ request, bouncer }: HttpContextContract): Promise<any> {
    const payload = await request.validate(ShowProductValidator)
    var product = (await Product.find(payload.params.id))!
    await bouncer.with('ProductPolicy').authorize('view', product)
    if (payload.load) {
      for (const load of payload.load) {
        await product.load(load)
      }
    }
    if (!payload.load?.includes('photo')) {
      await product.load('photo')
    }
    return product.toJSON()
  }

  /**
   * updates the product info
   * @param {HttpContextContract}
   * @returns {Promise<Product>}
   * @memberof ProductsController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Product", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/products/1
   */
  public async update({ request, bouncer }: HttpContextContract): Promise<any> {
    // validate also params.id
    const payload = await request.validate(UpdateProductValidator)
    const product = (await Product.find(payload.params.id))!
    await bouncer.with('ProductPolicy').authorize('update', product)
    product.name = payload.name ?? product.name
    product.description = payload.description ?? product.description
    product.storeId = payload.store_id ?? product.storeId
    product.sectionId = payload.section_id ?? product.sectionId
    product.product_type = payload.product_type ?? product.product_type
    product.barcode = payload.barcode ?? product.barcode
    product.price = payload.price ?? product.price
    product.body = payload.body ?? product.body
    product.meta = payload.meta ?? product.meta
    product.slug = payload.slug ?? product.slug

    await product.save()
    var photo: Image | null = null;
    if (payload.photo) {
      await product.setPhoto(payload.photo)
    }
    return {
      product: product.toJSON(),
      photo: photo,
    }
  }

  /**
   * deletes the product
   * @param {HttpContextContract}
   * @returns {Promise<void>}
   * @memberof ProductsController
   * @example
   * curl -X DELETE -H "Content-Type: application/json" http://localhost:3333/api/v1/products/{productId}
   */
  public async destroy({ request, bouncer }: HttpContextContract): Promise<void> {
    const payload = await request.validate(DestroyProductValidator)
    const product = (await Product.find(payload.params.id))!
    await bouncer.with('ProductPolicy').authorize('delete', product)
    return await product.delete()
  }

}

import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { CreateCategoryTranslationValidator, DestroyCategoryTranslationValidator, ListCategoryTranslationsValidator, ShowCategoryTranslationValidator, UpdateCategoryTranslationValidator } from 'App/Validators/CategoryTranslationValidator'
import { ModelObject } from '@ioc:Adonis/Lucid/Orm';
import CategoryTranslation from 'App/Models/translations/CategoryTranslation';

export default class CategoryTranslationsController {
  /**
    * returns the user's categoryTranslations as pangination list
    * @param {HttpContextContract}
    * @returns {Promise<{meta: any;data: ModelObject[];}>}
    * @memberof CategoryTranslationsController
    * @example
    * curl -X GET -H "Content-Type: application/json" -d '{"page": 1}' http://localhost:3333/api/v1/categoryTranslations
    */
  public async index({ request, bouncer }: HttpContextContract) {

    const payload = await request.validate(ListCategoryTranslationsValidator)
    await bouncer.with('CategoryTranslationPolicy').authorize('viewList', payload)
    var categoryTranslationsQuery = CategoryTranslation.query()
    var page = 1
    var limit = 12

    if (payload.search) {
      for (let i = 0; i < payload.search_in!.length; i++) {
        const element = payload.search_in![i];
        if (i == 0) {
          categoryTranslationsQuery = categoryTranslationsQuery.where(element, 'like', `%${payload.search}%`)
        } else {
          categoryTranslationsQuery = categoryTranslationsQuery.orWhere(element, 'like', `%${payload.search}%`)
        }
      }
    }
    if (payload.sort) {
      categoryTranslationsQuery = categoryTranslationsQuery.orderBy(payload.sort, payload.order)
    }
    if (payload.load) {
      for (const load of payload.load) {
        categoryTranslationsQuery = categoryTranslationsQuery.preload(load)
      }
    }
    if (payload.where) {
      for (const key in payload.where) {
        categoryTranslationsQuery = categoryTranslationsQuery.where(key, payload.where[key])
      }
    }
    page = payload.page || page
    limit = payload.limit || limit

    return (await categoryTranslationsQuery.paginate(page, Math.min(limit, 24))).toJSON()
  }

  /**
   * creates a new categoryTranslation for the user
   * @param {HttpContextContract}
   * @returns {Promise<{ categoryTranslation: ModelObject; photo: Image | null; }>}
   * @memberof CategoryTranslationsController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My CategoryTranslation", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/categoryTranslations
   */
  public async store({ request, bouncer }: HttpContextContract): Promise<{ category_translation: ModelObject }> {

    const payload = await request.validate(CreateCategoryTranslationValidator)
    await bouncer.with('CategoryTranslationPolicy').authorize('create', null)
    const categoryTranslation = await CategoryTranslation.create({
      locale: payload.locale,
      name: payload.name,
      description: payload.description,
      categoryId: payload.category_id
    })
    return {
      category_translation: categoryTranslation.toJSON()
    }
  }

  /**
   * returns the categoryTranslation info
   * @param {HttpContextContract}
   * @returns {Promise<CategoryTranslation>}
   * @memberof CategoryTranslationsController
   * @example
   * curl -X GET -H "Content-Type: application/json" http://localhost:3333/api/v1/categoryTranslations/1
   */
  public async show({ request, bouncer }: HttpContextContract): Promise<any> {
    const payload = await request.validate(ShowCategoryTranslationValidator)
    var categoryTranslation = (await CategoryTranslation.find(payload.params.id))!
    await bouncer.with('CategoryTranslationPolicy').authorize('view', categoryTranslation)
    if (payload.load) {
      for (const load of payload.load) {
        await categoryTranslation.load(load)
      }
    }
    return {category_translation:categoryTranslation.toJSON()}
  }

  /**
   * updates the categoryTranslation info
   * @param {HttpContextContract}
   * @returns {Promise<CategoryTranslation>}
   * @memberof CategoryTranslationsController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My CategoryTranslation", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/categoryTranslations/1
   */
  public async update({ request, bouncer }: HttpContextContract): Promise<{
    category_translation: ModelObject;
  }> {
    // validate also params.id
    const payload = await request.validate(UpdateCategoryTranslationValidator)
    const categoryTranslation = (await CategoryTranslation.find(payload.params.id))!
    await bouncer.with('CategoryTranslationPolicy').authorize('update', categoryTranslation)
    categoryTranslation.name = payload.name ?? categoryTranslation.name
    categoryTranslation.description = payload.description ?? categoryTranslation.description
    await categoryTranslation.save()
    return {
      category_translation: categoryTranslation.toJSON(),
    }
  }

  /**
   * deletes the categoryTranslation
   * @param {HttpContextContract}
   * @returns {Promise<void>}
   * @memberof CategoryTranslationsController
   * @example
   * curl -X DELETE -H "Content-Type: application/json" http://localhost:3333/api/v1/categoryTranslations/{categoryTranslationId}
   */
  public async destroy({ request, bouncer }: HttpContextContract): Promise<void> {
    const payload = await request.validate(DestroyCategoryTranslationValidator)
    const categoryTranslation = (await CategoryTranslation.find(payload.params.id))!
    await bouncer.with('CategoryTranslationPolicy').authorize('delete', categoryTranslation)
    return await categoryTranslation.delete()
  }


}

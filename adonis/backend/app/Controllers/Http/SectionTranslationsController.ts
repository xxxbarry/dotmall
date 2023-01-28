import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { ModelObject } from '@ioc:Adonis/Lucid/Orm';
import SectionTranslation from 'App/Models/translations/SectionTranslation';
import { ListSectionTranslationsValidator, CreateSectionTranslationValidator, ShowSectionTranslationValidator, UpdateSectionTranslationValidator, DestroySectionTranslationValidator } from 'App/Validators/SectionTranslationValidator';

export default class SectionTranslationsController {
  /**
    * returns the user's sectionTranslations as pangination list
    * @param {HttpContextContract}
    * @returns {Promise<{meta: any;data: ModelObject[];}>}
    * @memberof SectionTranslationsController
    * @example
    * curl -X GET -H "Content-Type: application/json" -d '{"page": 1}' http://localhost:3333/api/v1/sectionTranslations
    */
  public async index({ request, bouncer }: HttpContextContract) {

    const payload = await request.validate(ListSectionTranslationsValidator)
    await bouncer.with('SectionTranslationPolicy').authorize('viewList', payload)
    var sectionTranslationsQuery = SectionTranslation.query()
    var page = 1
    var limit = 12

    if (payload.search) {
      for (let i = 0; i < payload.search_in!.length; i++) {
        const element = payload.search_in![i];
        if (i == 0) {
          sectionTranslationsQuery = sectionTranslationsQuery.where(element, 'like', `%${payload.search}%`)
        } else {
          sectionTranslationsQuery = sectionTranslationsQuery.orWhere(element, 'like', `%${payload.search}%`)
        }
      }
    }
    if (payload.sort) {
      sectionTranslationsQuery = sectionTranslationsQuery.orderBy(payload.sort, payload.order)
    }
    if (payload.load) {
      for (const load of payload.load) {
        sectionTranslationsQuery = sectionTranslationsQuery.preload(load)
      }
    }
    if (payload.where) {
      for (const key in payload.where) {
        sectionTranslationsQuery = sectionTranslationsQuery.where(key, payload.where[key])
      }
    }
    page = payload.page || page
    limit = payload.limit || limit

    return (await sectionTranslationsQuery.paginate(page, Math.min(limit, 24))).toJSON()
  }

  /**
   * creates a new sectionTranslation for the user
   * @param {HttpContextContract}
   * @returns {Promise<{ sectionTranslation: ModelObject; photo: Image | null; }>}
   * @memberof SectionTranslationsController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My SectionTranslation", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/sectionTranslations
   */
  public async store({ request, bouncer }: HttpContextContract): Promise<{ section_translation: ModelObject }> {

    const payload = await request.validate(CreateSectionTranslationValidator)
    await bouncer.with('SectionTranslationPolicy').authorize('create', null)
    const sectionTranslation = await SectionTranslation.create({
      locale: payload.locale,
      name: payload.name,
      description: payload.description,
      sectionId: payload.section_id,
    })
    return {
      section_translation: sectionTranslation.toJSON()
    }
  }

  /**
   * returns the sectionTranslation info
   * @param {HttpContextContract}
   * @returns {Promise<SectionTranslation>}
   * @memberof SectionTranslationsController
   * @example
   * curl -X GET -H "Content-Type: application/json" http://localhost:3333/api/v1/sectionTranslations/1
   */
  public async show({ request, bouncer }: HttpContextContract): Promise<any> {
    const payload = await request.validate(ShowSectionTranslationValidator)
    var sectionTranslation = (await SectionTranslation.find(payload.params.id))!
    await bouncer.with('SectionTranslationPolicy').authorize('view', sectionTranslation)
    if (payload.load) {
      for (const load of payload.load) {
        await sectionTranslation.load(load)
      }
    }
    return {section_translation:sectionTranslation.toJSON()}
  }

  /**
   * updates the sectionTranslation info
   * @param {HttpContextContract}
   * @returns {Promise<SectionTranslation>}
   * @memberof SectionTranslationsController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My SectionTranslation", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/sectionTranslations/1
   */
  public async update({ request, bouncer }: HttpContextContract): Promise<{
    section_translation: ModelObject;
  }> {
    // validate also params.id
    const payload = await request.validate(UpdateSectionTranslationValidator)
    const sectionTranslation = (await SectionTranslation.find(payload.params.id))!
    await bouncer.with('SectionTranslationPolicy').authorize('update', sectionTranslation)
    sectionTranslation.name = payload.name ?? sectionTranslation.name
    sectionTranslation.description = payload.description ?? sectionTranslation.description
    await sectionTranslation.save()
    return {
      section_translation: sectionTranslation.toJSON(),
    }
  }

  /**
   * deletes the sectionTranslation
   * @param {HttpContextContract}
   * @returns {Promise<void>}
   * @memberof SectionTranslationsController
   * @example
   * curl -X DELETE -H "Content-Type: application/json" http://localhost:3333/api/v1/sectionTranslations/{sectionTranslationId}
   */
  public async destroy({ request, bouncer }: HttpContextContract): Promise<void> {
    const payload = await request.validate(DestroySectionTranslationValidator)
    const sectionTranslation = (await SectionTranslation.find(payload.params.id))!
    await bouncer.with('SectionTranslationPolicy').authorize('delete', sectionTranslation)
    return await sectionTranslation.delete()
  }


}

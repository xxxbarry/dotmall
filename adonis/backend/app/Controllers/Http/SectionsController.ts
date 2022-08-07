import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import  { CreateSectionValidator, DestroySectionValidator, ListSectionsValidator, ShowSectionValidator, UpdateSectionValidator } from 'App/Validators/SectionValidator'
import { Image } from 'App/Models/File'
import { ModelObject } from '@ioc:Adonis/Lucid/Orm';
import Section from 'App/Models/accounts/business/stores/Section';

export default class SectionsController {
  /**
    * returns the user's sections as pangination list
    * @param {HttpContextContract}
    * @returns {Promise<{meta: any;data: ModelObject[];}>}
    * @memberof SectionsController
    * @example
    * curl -X GET -H "Content-Type: application/json" -d '{"page": 1}' http://localhost:3333/api/v1/sections
    */
  public async index({ request, bouncer }: HttpContextContract): Promise<{
    meta: any;
    data: ModelObject[];
  }> {
    const payload = await request.validate(ListSectionsValidator)
    await bouncer.with('SectionPolicy').authorize('viewList', payload)
    var sectionsQuery = Section.query()
    var page = 1
    var limit = 24


    if (payload.search) {
      for (let i = 0; i < payload.search_in!.length; i++) {
        const element = payload.search_in![i];
        if (i == 0) {
          sectionsQuery = sectionsQuery.where(element, 'like', `%${payload.search}%`)
        } else {
          sectionsQuery = sectionsQuery.orWhere(element, 'like', `%${payload.search}%`)
        }
      }
    }
    if (payload.sort) {
      sectionsQuery = sectionsQuery.orderBy(payload.sort, payload.order)
    }
    if (payload.load) {
      for (const load of payload.load) {
        sectionsQuery = sectionsQuery.preload(load)
      }
    }
    if (payload.where) {
      for (const key in payload.where) {
        sectionsQuery = sectionsQuery.where(key, payload.where[key])
      }
    }
    page = payload.page || page
    limit = payload.limit || limit

    return (await sectionsQuery.paginate(page, Math.min(limit, 24))).toJSON()
  }

  /**
   * creates a new section for the user
   * @param {HttpContextContract}
   * @returns {Promise<{ section: ModelObject; photo: Image | null; }>}
   * @memberof SectionsController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Section", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/sections
   */
  public async store({ request, bouncer }: HttpContextContract): Promise<{ section: ModelObject; photo: Image | null; }> {

    await bouncer.with('SectionPolicy').authorize('create', null)
    const payload = await request.validate(CreateSectionValidator)
    const section = await Section.create({
      name: payload.name,
      description: payload.description,
      storeId: payload.store_id,
      slug: payload.slug,
    })
    var photo: Image | null = null;
    if (payload.photo) {
      photo = await section.setPhoto(payload.photo)
    }
    return {
      section: section.toJSON(),
      photo: photo,
    }
  }

  /**
   * returns the section info
   * @param {HttpContextContract}
   * @returns {Promise<Section>}
   * @memberof SectionsController
   * @example
   * curl -X GET -H "Content-Type: application/json" http://localhost:3333/api/v1/sections/1
   */
  public async show({ auth, request, bouncer }: HttpContextContract): Promise<any> {
    const payload = await request.validate(ShowSectionValidator)
    var section = (await Section.find(payload.params.id))!
    await bouncer.with('SectionPolicy').authorize('view', section)
    if (payload.load) {
      for (const load of payload.load) {
        await section.load(load)
      }
    }
    if (!payload.load?.includes('photo')) {
      await section.load('photo')
    }
    return section.toJSON()
  }

  /**
   * updates the section info
   * @param {HttpContextContract}
   * @returns {Promise<Section>}
   * @memberof SectionsController
   * @example
   * curl -X PUT -H "Content-Type: application/json" -d '{"name": "My Section", "type": "Bank", "number": "123456789"}' http://localhost:3333/api/v1/sections/1
   */
  public async update({ request, bouncer }: HttpContextContract): Promise<any> {
    // validate also params.id
    const payload = await request.validate(UpdateSectionValidator)
    const section = (await Section.find(payload.params.id))!
    await bouncer.with('SectionPolicy').authorize('update', section)
    section.name = payload.name ?? section.name
    section.description = payload.description ?? section.description
    section.slug = payload.slug ?? section.slug
    section.storeId = payload.store_id ?? section.storeId
    await section.save()
    var photo: Image | null = null;
    if (payload.photo) {
      await section.setPhoto(payload.photo)
    }
    return {
      section: section.toJSON(),
      photo: photo,
    }
  }

  /**
   * deletes the section
   * @param {HttpContextContract}
   * @returns {Promise<void>}
   * @memberof SectionsController
   * @example
   * curl -X DELETE -H "Content-Type: application/json" http://localhost:3333/api/v1/sections/{sectionId}
   */
  public async destroy({ request, bouncer }: HttpContextContract): Promise<void> {
    const payload = await request.validate(DestroySectionValidator)
    const section = (await Section.find(payload.params.id))!
    await bouncer.with('SectionPolicy').authorize('delete', section)
    return await section.delete()
  }


}

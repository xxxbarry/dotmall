import { action } from '@ioc:Adonis/Addons/Bouncer'
import { BasePolicy } from '@ioc:Adonis/Addons/Bouncer'
import SectionTranslation from 'App/Models/translations/SectionTranslation'
import User from 'App/Models/User'

export default class SectionTranslationPolicy extends BasePolicy {

    @action({ allowGuest: true })
    public async viewList(user: User| null, payload: any) {
        return true
    }
    @action({ allowGuest: true })
    public async view(user: User | null, sectionTranslation: SectionTranslation) {
        return true;
    }
    // create a section
    public async create(user: User | null, payload: any) {
        return true
    }
    // update a section
    public async update(user: User | null, sectionTranslation: SectionTranslation) {
      return true
    }
    public delete = this.update
}

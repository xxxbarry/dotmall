import { action } from '@ioc:Adonis/Addons/Bouncer'
import { BasePolicy } from '@ioc:Adonis/Addons/Bouncer'
import Account from 'App/Models/Account'
import MerchantProfile from 'App/Models/accounts/profiles/MerchantProfile'
import Category from 'App/Models/Category'
import CategoryTranslation from 'App/Models/translations/CategoryTranslation'
import User from 'App/Models/User'

export default class CategoryTranslationPolicy extends BasePolicy {

    @action({ allowGuest: true })
    public async viewList(user: User| null, payload: any) {
        return true
    }
    @action({ allowGuest: true })
    public async view(user: User | null, categoryTranslation: CategoryTranslation) {
        return true;
    }
    // create a category
    public async create(user: User | null, payload: any) {
        return true
    }
    // update a category
    public async update(user: User | null, categoryTranslation: CategoryTranslation) {
      return true
    }
    public delete = this.update
}

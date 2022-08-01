import { action } from '@ioc:Adonis/Addons/Bouncer'
import { BasePolicy } from '@ioc:Adonis/Addons/Bouncer'
import ProductTranslation from 'App/Models/translations/ProductTranslation'
import User from 'App/Models/User'

export default class ProductTranslationPolicy extends BasePolicy {

    @action({ allowGuest: true })
    public async viewList(user: User| null, payload: any) {
        return true
    }
    @action({ allowGuest: true })
    public async view(user: User | null, productTranslation: ProductTranslation) {
        return true;
    }
    // create a product
    public async create(user: User | null, payload: any) {
        return true
    }
    // update a product
    public async update(user: User | null, productTranslation: ProductTranslation) {
      return true
    }
    public delete = this.update
}

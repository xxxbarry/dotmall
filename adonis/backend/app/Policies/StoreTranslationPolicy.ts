import { action } from '@ioc:Adonis/Addons/Bouncer'
import { BasePolicy } from '@ioc:Adonis/Addons/Bouncer'
import Account from 'App/Models/Account'
import Store, { StoreStatus } from 'App/Models/accounts/business/stores/Store'
import MerchantProfile from 'App/Models/accounts/profiles/MerchantProfile'
import StoreTranslation from 'App/Models/translations/StoreTranslation'
import User from 'App/Models/User'

export default class StoreTranslationPolicy extends BasePolicy {

    @action({ allowGuest: true })
    public async viewList(user: User| null, payload: any) {
        return true
    }
    @action({ allowGuest: true })
    public async view(user: User | null, storeTranslation: StoreTranslation) {
        return true;
    }
    // create a store
    public async create(user: User | null, store: Store) {
        return true
    }
    // update a store
    public async update(user: User | null, storeTranslation: StoreTranslation) {
      return true
    }
    public delete = this.update
}

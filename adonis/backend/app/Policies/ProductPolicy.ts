import { action } from '@ioc:Adonis/Addons/Bouncer';
import { BasePolicy } from '@ioc:Adonis/Addons/Bouncer'
import Product from 'App/Models/accounts/business/stores/Product';
import MerchantProfile from 'App/Models/accounts/profiles/MerchantProfile';
import User from 'App/Models/User';

// TODO: must configure (only admin can create/update/delete)
export default class ProductPolicy extends BasePolicy {

    @action({ allowGuest: true })
    public async viewList(user: User | null, payload: any) {
        return true
    }
    @action({ allowGuest: true })
    public async view(user: User | null, product: Product) {
        return true;
    }
    // create a product
    public async create(user: User | null, payload: any) {
        if (user) {
            return true
        }
        return false
    }
    // update a product
    public async update(user: User | null, product: Product) {
        if (user) {
                return true
        }
        return false
    }
    public delete = this.update
}

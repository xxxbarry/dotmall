import { action } from '@ioc:Adonis/Addons/Bouncer';
import { BasePolicy } from '@ioc:Adonis/Addons/Bouncer'
import MerchantProfile from 'App/Models/accounts/profiles/MerchantProfile';
import Category from 'App/Models/Category';
import User from 'App/Models/User';

// TODO: must configure (only admin can create/update/delete)
export default class CategoryPolicy extends BasePolicy {

    @action({ allowGuest: true })
    public async viewList(user: User | null, payload: any) {
        return true
    }
    @action({ allowGuest: true })
    public async view(user: User | null, category: Category) {
        return true;
    }
    // create a category
    @action({ allowGuest: true })
    public async create(user: User | null, payload: any) {
      return true
        if (user) {
            return true
        }
        return false
    }
    // update a category
    @action({ allowGuest: true })
    public async update(user: User | null, category: Category) {return true
        if (user) {
                return true
        }
        return false
    }

    @action({ allowGuest: true })
    public delete = this.update
}

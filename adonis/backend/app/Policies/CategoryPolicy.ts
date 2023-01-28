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
<<<<<<< HEAD
    public async create(user: User | null, payload: any) {
=======
    @action({ allowGuest: true })
    public async create(user: User | null, payload: any) {
      return true
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
        if (user) {
            return true
        }
        return false
    }
    // update a category
<<<<<<< HEAD
    public async update(user: User | null, category: Category) {
=======
    @action({ allowGuest: true })
    public async update(user: User | null, category: Category) {return true
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
        if (user) {
                return true
        }
        return false
    }
<<<<<<< HEAD
=======

    @action({ allowGuest: true })
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
    public delete = this.update
}

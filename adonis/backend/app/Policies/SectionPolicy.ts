import { action } from '@ioc:Adonis/Addons/Bouncer';
import { BasePolicy } from '@ioc:Adonis/Addons/Bouncer'
import Section from 'App/Models/accounts/business/stores/Section';
import MerchantProfile from 'App/Models/accounts/profiles/MerchantProfile';
import User from 'App/Models/User';

// TODO: must configure (only admin can create/update/delete)
export default class SectionPolicy extends BasePolicy {

    @action({ allowGuest: true })
    public async viewList(user: User | null, payload: any) {
        return true
    }
    @action({ allowGuest: true })
    public async view(user: User | null, section: Section) {
        return true;
    }
    // create a section
    public async create(user: User | null, payload: any) {
        if (user) {
            return true
        }
        return false
    }
    // update a section
    public async update(user: User | null, section: Section) {
        if (user) {
                return true
        }
        return false
    }
    public delete = this.update
}

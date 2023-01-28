import { action } from '@ioc:Adonis/Addons/Bouncer'
import { BasePolicy } from '@ioc:Adonis/Addons/Bouncer'
import Account from 'App/Models/Account'
import Store, { StoreStatus } from 'App/Models/accounts/business/stores/Store'
import MerchantProfile from 'App/Models/accounts/profiles/MerchantProfile'
import User from 'App/Models/User'

export default class StorePolicy extends BasePolicy {

    @action({ allowGuest: true })
    public async viewList(user: User| null, payload: any) {
        return true
    }
    @action({ allowGuest: true })
    public async view(user: User | null, store: Store) {
        return true;
        if (store.status === StoreStatus.active) {
            return true
        } else if (user) {
            await store.load('merchant')
            await store.merchant.load('account')
            if (store.merchant.account.userId === user!.id) {
                return true
            }
        }
        return false
    }
    // create a store
    public async create(user: User | null, payload: any) {
        var merchantProfile = await MerchantProfile.find(payload.merchant_profile_id)
        await merchantProfile?.load('account')
        if (user && merchantProfile?.account.userId === user.id) {
            return true
        }
        return false
    }
    // update a store
    public async update(user: User | null, store: Store) {
        if (user) {
            await store.load('merchant')
            await store.merchant.load('account')
            if (store.merchant.account.userId === user!.id) {
                return true
            }
        }
        return false
    }
    public delete = this.update
}

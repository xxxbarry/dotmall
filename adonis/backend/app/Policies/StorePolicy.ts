import { BasePolicy } from '@ioc:Adonis/Addons/Bouncer'
import Store, { StoreStatus } from 'App/Models/accounts/business/stores/Store'
import MerchantProfile from 'App/Models/accounts/profiles/MerchantProfile'
import { StorePermission } from 'App/Models/Permission'
import User from 'App/Models/User'

export default class StorePolicy extends BasePolicy {
    public async view(user: User | null, store: Store) {
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
    public async create(user: User | null) {
        if (user) {
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
}

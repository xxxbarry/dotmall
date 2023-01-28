import { BasePolicy } from '@ioc:Adonis/Addons/Bouncer'
import Account from 'App/Models/Account'
import User from 'App/Models/User'

export default class AccountPolicy extends BasePolicy {
    public async viewList(user: User, payload: any) {
<<<<<<< HEAD
        if (user && user.id === payload.where.user_id) {
            return true
        }
        return false
    }
    public async view(user: User | null, account: Account | Array<Account> | null) {
        return true
=======
        // if (user && user.id === payload?.where?.user_id) {
            return true
        // }
        return false
    }
    public async view(user: User | null, account: Account | null) {
        return user?.id === account?.userId
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
    }
    public async create(user: User | null, account: Account | null) {
        if (user) {
            return true
        }
        return false
    }
    public async update(user: User | null, account: Account) {
<<<<<<< HEAD
        if (user?.id === account.userId) {
            return true
        }
=======
        // if (user?.id === account.userId) {
            return true
        // }
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
        return false
    }
    public delete = this.update

}

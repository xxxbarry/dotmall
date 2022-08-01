import { BasePolicy } from '@ioc:Adonis/Addons/Bouncer'
import Account from 'App/Models/Account'
import User from 'App/Models/User'

export default class AccountPolicy extends BasePolicy {
    public async viewList(user: User, payload: any) {
        if (user && user.id === payload.where.user_id) {
            return true
        }
        return false
    }
    public async view(user: User | null, account: Account | null) {
        return user?.id === account?.userId
    }
    public async create(user: User | null, account: Account | null) {
        if (user) {
            return true
        }
        return false
    }
    public async update(user: User | null, account: Account) {
        if (user?.id === account.userId) {
            return true
        }
        return false
    }
    public delete = this.update

}

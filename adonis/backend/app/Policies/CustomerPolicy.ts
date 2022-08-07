import { BasePolicy } from '@ioc:Adonis/Addons/Bouncer'
import User from 'App/Models/User'
import Account from 'App/Models/Account'
import CustomerProfile from 'App/Models/accounts/profiles/CustomerProfile'

export default class CustomerPolicy extends BasePolicy {
	public async viewList(user: User, payload: any) {
    return true

		if (user) {
			var account = await Account.find(payload.where.account_id)
			return account && user.id === account.userId
		}
		return false
	}
	public async view(user: User, customerProfile: CustomerProfile) {
		return true
	}
	public async create(user: User, accountId: string) {
		var account = await Account.find(accountId)
		if (account && user.id === account.userId) {
			return true
		}
		return false
	}
	public async update(user: User, customerProfile: CustomerProfile) {
		return this.create(user, customerProfile.accountId)
	}
	public delete = this.update


}

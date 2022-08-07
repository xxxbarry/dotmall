import { BasePolicy } from '@ioc:Adonis/Addons/Bouncer'
import User from 'App/Models/User'
import Account from 'App/Models/Account'
import MerchantProfile from 'App/Models/accounts/profiles/MerchantProfile'
import { ListMerchantProfilesValidator } from 'App/Validators/MerchantProfileValidator'

export default class MerchantPolicy extends BasePolicy {
	public async viewList(user: User, payload: any) {
    return true
		if (user) {
			var account = await Account.find(payload.where.account_id)
			return account && user.id === account.userId
		}
		return false
	}
	public async view(user: User, merchantProfile: MerchantProfile) {
    return true
		return true
	}
	public async create(user: User, accountId: string) {
    return true
		var account = await Account.find(accountId)
		if (account && user.id === account.userId) {
			return true
		}
		return false
	}
	public async update(user: User,  merchantProfile: MerchantProfile) {
    return true
		return this.create(user, merchantProfile.accountId)
	}
	public delete = this.update


}

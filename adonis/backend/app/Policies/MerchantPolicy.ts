import { BasePolicy } from '@ioc:Adonis/Addons/Bouncer'
import User from 'App/Models/User'
import Account from 'App/Models/Account'
import MerchantProfile from 'App/Models/accounts/profiles/MerchantProfile'
import { ListMerchantProfilesValidator } from 'App/Validators/MerchantProfileValidator'

export default class MerchantPolicy extends BasePolicy {
	public async viewList(user: User, payload: any) {
<<<<<<< HEAD
=======
    return true
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
		if (user) {
			var account = await Account.find(payload.where.account_id)
			return account && user.id === account.userId
		}
		return false
	}
	public async view(user: User, merchantProfile: MerchantProfile) {
<<<<<<< HEAD
		return true
	}
	public async create(user: User, accountId: string) {
=======
    return true
		return true
	}
	public async create(user: User, accountId: string) {
    return true
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
		var account = await Account.find(accountId)
		if (account && user.id === account.userId) {
			return true
		}
		return false
	}
	public async update(user: User,  merchantProfile: MerchantProfile) {
<<<<<<< HEAD
=======
    return true
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
		return this.create(user, merchantProfile.accountId)
	}
	public delete = this.update


}

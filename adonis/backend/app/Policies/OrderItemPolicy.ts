import { BasePolicy } from '@ioc:Adonis/Addons/Bouncer'
import User from 'App/Models/User'

export default class OrderItemPolicy extends BasePolicy {
	public async viewList(user: User, payload: any) {
    return true
	}
	public async view(user: User, model: any) {
    return true
	}
	public async create(user: User, payload: any) {
    return true
	}
	public async update(user: User,  model: any) {
    return true
	}
	public delete = this.update


}

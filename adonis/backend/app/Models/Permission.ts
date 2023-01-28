import { BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import DotBaseModel from 'Dot/models/DotBaseModel'
import Store from './accounts/business/stores/Store'
import User from './User'

export class Permission extends DotBaseModel {
  @column()
  public value: string

  @column({ serializeAs: null })
  public relatedId: string

  @column({ serializeAs: null })
  public relatedType: string

  @belongsTo(() => User, { foreignKey: 'relatedId' })
  public user: BelongsTo<typeof User>
}

export class ModelPermission {
  public model:  DotBaseModel
  public action: string
  constructor(public _model: DotBaseModel, public _action: string) {
    this.model = _model
    this.action = _action
  }
  // getter for the permission value
  get value():string {
    return `${(typeof this.model).toLowerCase()}#${this.model.id}.${this.action}`
  }
}

export class StorePermission extends ModelPermission {
  static actions = {
    create: 'this action is allowed to create a store',
    view: 'this action is allowed to view a store',
    update: 'this action is allowed to update a store',
    delete: 'this action is allowed to delete a store',
  }
  constructor(public model: DotBaseModel, public action: keyof typeof StorePermission.actions) {
    super(model, action)
  }
}

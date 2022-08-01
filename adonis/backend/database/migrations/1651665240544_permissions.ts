import DotBaseSchema from '../../dot/DotBaseSchema';
import { Knex } from 'knex'

export default class Permissions extends DotBaseSchema {
  protected tableName = 'permissions'
  public useTimestamps = false
  public useSoftDeletes = false
  public useValidatedAt = false
  public useRelatedTo = true
  public usePivotTable = true
  // useTranslation
  // public useTranslation = true
  public setup(table: Knex.CreateTableBuilder): void {
    // this is th schema for the table of the permissions
    // every permission has the type of model which it is related to
    // and the the id of the model
    // and the list of actions that the permission has
    table.string('value').notNullable()
  }
}

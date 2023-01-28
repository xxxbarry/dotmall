import DotBaseSchema from '../../dot/DotBaseSchema';
import { Knex } from 'knex'
import User from 'App/Models/User';

export default class Addresses extends DotBaseSchema {
  protected tableName = 'addresses'
  public useTimestamps = false
  public useSoftDeletes = true
  public useValidatedAt = true
  public useRelatedTo = true
<<<<<<< HEAD
=======
  public useRelations = [User]
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
  public usePivotTable = true
  // useTranslation
  // public useTranslation = true
  public setup(table: Knex.CreateTableBuilder): void {
    // the address primary is line 1
    table.string('primary').notNullable()
    table.string('secondary').nullable()
    table.string('city').nullable()
    table.string('state').nullable()
    table.string('zip').nullable()
    table.string('country').nullable()
    table.double('latitude').nullable()
    table.double('longitude').nullable()
  }
}

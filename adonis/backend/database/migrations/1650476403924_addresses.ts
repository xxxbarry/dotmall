import DotBaseSchema from '../../dot/DotBaseSchema';
import { Knex } from 'knex'

export default class Addresses extends DotBaseSchema {
  protected tableName = 'addresses'
  public useTimestamps = false
  public useSoftDeletes = true
  public useValidatedAt = true
  public useRelatedTo = true
  public useUserRelation = true
  public usePivotTable = true
  // useTranslation
  // public useTranslation = true
  public setup(table: Knex.CreateTableBuilder): void {
    // the address primary is line 1
    table.string('primary').nullable()
    table.string('secondary').nullable()
    table.string('city').nullable()
    table.string('state').nullable()
    table.string('zip').nullable()
    table.string('country').nullable()
    table.string('latitude').nullable()
    table.string('longitude').nullable()
  }
}

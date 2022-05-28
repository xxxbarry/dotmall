
import SubProfilesSchema from '../../../../dot/SubProfilesSchema'
import { Knex } from 'knex'


export default class CustomerProfiles extends SubProfilesSchema {
  protected tableName = 'customer_profiles'

  public setup(table: Knex.CreateTableBuilder): void {
    super.setup(table)
    // table.string('fullname').notNullable()
    // table.boolean('gender').nullable()
    // table.timestamp('birth_at', { useTz: true }).nullable()
  }

}

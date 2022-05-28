import SubProfilesSchema from '../../../../dot/SubProfilesSchema'
import { Knex } from 'knex'


export default class MerchantProfiles extends SubProfilesSchema {
  protected tableName = 'merchant_profiles'

  public setup(table: Knex.CreateTableBuilder): void {
    super.setup(table)
    // table.string('fullname').notNullable()
    // table.boolean('gender').nullable()
  }

}

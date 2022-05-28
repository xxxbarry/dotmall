import SubAccountSchema from '../../dot/SubAccountsSchema'
import { Knex } from 'knex';

export default class BusinessAccounts extends SubAccountSchema {
  protected tableName = 'business_accounts'
  public setup(table: Knex.CreateTableBuilder): void {
    super.setup(table)
  }

}

import SubAccountSchema from '../../dot/SubAccountsSchema'
import { Knex } from 'knex';

export default class PersonalAccounts extends SubAccountSchema {
  protected tableName = 'personal_accounts'

  public setup(table: Knex.CreateTableBuilder): void {
    super.setup(table)
  }

}

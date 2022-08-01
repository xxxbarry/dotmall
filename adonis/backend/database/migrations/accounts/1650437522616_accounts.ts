import { Knex } from 'knex';
import SubAccountSchema from '../../../dot/SubAccountsSchema'

export default class Accounts extends SubAccountSchema {
  protected tableName = 'accounts'
  public usePivotTable: boolean = true

  public setup(table: Knex.CreateTableBuilder): void {
    // account_type should be enum (personal, business, company)
    table.string('name').notNullable()
    table.string('description').nullable()
    table.json('data').nullable()
    table.string('type').notNullable()
    table
      .string('user_id')
      .references('users.id')
      .onDelete('CASCADE') // delete when user is deleted

  }

}

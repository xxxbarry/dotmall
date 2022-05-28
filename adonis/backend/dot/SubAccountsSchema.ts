import DotBaseSchema from './DotBaseSchema';
import { Knex } from 'knex';

export default class SubAccountsSchema extends DotBaseSchema {
  protected tableName = 'accounts'
  public useValidatedAt: boolean = true
  public useSoftDeletes: boolean = true
  public useTimestamps: boolean =false
  public setup(table: Knex.CreateTableBuilder): void {
    // all account have a name field
    table.string('name').notNullable();
    // all account have a bio field
    table.text('description').nullable()
    // avatar is file
    // table.string('avatar_file_id').references('files.id').nullable()
    // cover is file
    // table.string('cover_file_id').references('files.id').nullable()
    table
      .string('account_id')
      .references('accounts.id')
      .onDelete('CASCADE') // delete when account is deleted
  }
}
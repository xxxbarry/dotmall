import DotBaseSchema from './DotBaseSchema';
import { Knex } from 'knex';

export default class SubProfilesSchema extends DotBaseSchema {
  protected tableName = 'profiles'
  public useValidatedAt: boolean = true;
  public useSoftDeletes: boolean = true;
  public useTimestamps: boolean =false
  public useRelatedTo: boolean = false
  public setup(table: Knex.CreateTableBuilder): void {
    // email and phone are relations from Email and Phone tables
    // table.string('email_id').references('emails.id').nullable()
    // table.string('phone_id').references('phones.id').nullable()
    // // all profiles have a address_id field
    // table.string('address_id').references('addresses.id').nullable()
    table
      .string('account_id')
      .references('accounts.id')
      .onDelete('CASCADE') // delete when account is deleted
  }
}
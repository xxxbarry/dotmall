import ContactOptionSchema from 'Dot/ContactOptionSchema';
import { Knex } from 'knex';

export default class Emails extends ContactOptionSchema {
  protected tableName = 'emails'
  public setup(table: Knex.CreateTableBuilder): void {
    super.setup(table);
    table.string('value').notNullable().unique()
  }
}

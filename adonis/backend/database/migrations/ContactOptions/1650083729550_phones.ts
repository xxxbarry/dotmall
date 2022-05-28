import ContactOptionSchema from 'Dot/ContactOptionSchema';
import { Knex } from 'knex';

export default class Phones extends ContactOptionSchema {
  protected tableName = 'phones'
  public setup(table: Knex.CreateTableBuilder): void {
    super.setup(table);
    table.string('value', 12).notNullable()//.unique()
  }
}
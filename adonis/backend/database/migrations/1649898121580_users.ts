import DotBaseSchema from '../../dot/DotBaseSchema';
import { Knex } from 'knex'

export default class UsersSchema extends DotBaseSchema {
  protected tableName = 'users'
  public setup(table: Knex.CreateTableBuilder): void {
    // full phone number contains country code, size is 11
    table.string('password', 180).notNullable()
    table.string('remember_me_token').nullable()
  }
}

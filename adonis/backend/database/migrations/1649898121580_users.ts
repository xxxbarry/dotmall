import DotBaseSchema from '../../dot/DotBaseSchema';
import { Knex } from 'knex'

export default class UsersSchema extends DotBaseSchema {
  protected tableName = 'users'
  public setup(table: Knex.CreateTableBuilder): void {
    table.string('password', 180).notNullable()
    table.string('remember_me_token').nullable()
  }
}

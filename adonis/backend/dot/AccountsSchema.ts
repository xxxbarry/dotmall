import DotBaseSchema from './DotBaseSchema';
import { Knex } from 'knex';

export default class AccountsSchema extends DotBaseSchema {
  protected tableName = 'accounts'
  public useValidatedAt: boolean = true;
  public useSoftDeletes: boolean = true;
  public setup(_table: Knex.CreateTableBuilder): void {
  }
}
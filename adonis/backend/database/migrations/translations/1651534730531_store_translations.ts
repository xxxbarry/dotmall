import DotBaseSchema from '../../../dot/DotBaseSchema'
import { Knex } from 'knex'

export default class StoreTranslations extends DotBaseSchema {
  protected tableName = 'store_translations'
  public useValidatedAt: boolean = false
  public useSoftDeletes: boolean = false
  public useTimestamps: boolean = false
  public setup(table: Knex.CreateTableBuilder): void {
    table.string('locale', 5).notNullable()
    table.string('name').nullable()
    table.string('description', 500).nullable()
    table.string('store_id').references('stores.id').onDelete('CASCADE').notNullable()
  }
}

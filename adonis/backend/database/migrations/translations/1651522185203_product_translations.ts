import DotBaseSchema from '../../../dot/DotBaseSchema'
import { Knex } from 'knex'

export default class ProductTranslations extends DotBaseSchema {
  protected tableName = 'product_translations'
  public useValidatedAt: boolean = false
  public useSoftDeletes: boolean = false
  public useTimestamps: boolean = false
  public setup(table: Knex.CreateTableBuilder): void {
    table.string('locale', 5).notNullable()
    table.string('name').nullable()
    table.string('description', 500).nullable()
    table.text('body').nullable()
    table.string('slug').nullable()
    table.string('product_id').references('products.id').onDelete('CASCADE').notNullable()
  }
}

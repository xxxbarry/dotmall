
import DotBaseSchema from '../../../../dot/DotBaseSchema';
import { Knex } from 'knex'

export default class Products extends DotBaseSchema {
  protected tableName = 'products'
  public useTimestamps = true
  public useSoftDeletes = true
  public useValidatedAt = true
  public useTranslation = "product"
  public useStatus = true
  public setup(table: Knex.CreateTableBuilder): void {
    table.string('name').notNullable()
    table.string('description').nullable()
    table.text('body').nullable()
    table.string('slug').nullable().unique()
    table.string('barcode').nullable()
    
    // addetional data as json
    table.json('meta').nullable()
    table.double('price').defaultTo(0)

    table.string('product_type')

    table
      .string('store_id')
      .references('stores.id')
      .onDelete('CASCADE')
    table
      .string('category_id')
      .references('categories.id')
      .onDelete('CASCADE')
  }
}

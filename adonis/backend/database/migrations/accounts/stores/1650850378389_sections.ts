import BaseSchema from '@ioc:Adonis/Lucid/Schema'
import DotBaseSchema from 'Dot/DotBaseSchema'
import { Knex } from 'knex'

export default class Sections extends DotBaseSchema {
  protected tableName = 'sections'

  public useTimestamps = true
  public useSoftDeletes = true
  public useValidatedAt = true
  public useTranslation = 'section'
  public setup(table: Knex.CreateTableBuilder): void {
    table.string('name').notNullable()
    table.string('description', 500).nullable()
    table.string('slug').nullable().unique()
    table.string('store_id').references('stores.id').onDelete('CASCADE')
    table.string('category_id').references('categories.id').onDelete('CASCADE')
  }
}

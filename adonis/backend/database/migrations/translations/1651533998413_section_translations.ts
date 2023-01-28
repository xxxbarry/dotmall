import DotBaseSchema from '../../../dot/DotBaseSchema'
import { Knex } from 'knex'

export default class SectionTranslations extends DotBaseSchema {
  protected tableName = 'section_translations'
  public useValidatedAt: boolean = false
  public useSoftDeletes: boolean = false
  public useTimestamps: boolean = false
  public setup(table: Knex.CreateTableBuilder): void {
    table.string('locale', 5).notNullable()
    table.string('name').nullable()
    table.string('description', 500).nullable()
    table.string('section_id').references('sections.id').onDelete('CASCADE').notNullable()
  }
}

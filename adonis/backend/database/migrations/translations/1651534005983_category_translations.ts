import DotBaseSchema from '../../../dot/DotBaseSchema';
import { Knex } from 'knex';

export default class CategoryTranslations extends DotBaseSchema {
  protected tableName = 'category_translations'
  public useValidatedAt: boolean = false;
  public useSoftDeletes: boolean = false;
  public useTimestamps: boolean = false;
  public setup(table: Knex.CreateTableBuilder): void {
    table.string('locale', 5).notNullable();
    table.string('name').nullable()
    table.string('description').nullable()
    table
      .string('category_id')
      .references('categories.id')
      .onDelete('CASCADE')
  }
}
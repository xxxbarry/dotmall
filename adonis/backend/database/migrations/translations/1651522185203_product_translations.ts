
import DotBaseSchema from '../../../dot/DotBaseSchema';
import { Knex } from 'knex';

export default class ProductTranslations extends DotBaseSchema {
    protected tableName = 'product_translations'
    public useValidatedAt: boolean = false;
    public useSoftDeletes: boolean = false;
    public useTimestamps: boolean =false;
    public setup(table: Knex.CreateTableBuilder): void {
        table.string('locale', 5).notNullable();
        table.string('name').nullable()
        table.string('description').nullable()
        table.text('body').nullable()
        table.double('price').nullable()
        table
            .string('product_id')
            .references('products.id')
            .onDelete('CASCADE')
    }
}
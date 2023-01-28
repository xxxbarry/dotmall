// import DotBaseSchema from './DotBaseSchema';
// import { Knex } from 'knex';

// export default class ProductsSchema extends DotBaseSchema {
//   protected tableName = 'products'
//   public useValidatedAt: boolean = true;
//   public useSoftDeletes: boolean = true;
//   public setup(_table: Knex.CreateTableBuilder): void {
//     _table.string('name').notNullable()
//     _table.string('description').nullable()
//     _table.text('body').nullable()
//     _table.string('slug').nullable()
//     _table.string('barcode').nullable()
//     _table.string('type').defaultTo('simple_product')
//   }
// }

// import DotBaseSchema from '../../dot/DotBaseSchema';
// import { Knex } from 'knex'

// export default class Prices extends DotBaseSchema {
//   protected tableName = 'prices'
//   public useTimestamps = true
//   public useSoftDeletes = true
//   public useValidatedAt = true
//   public useTranslation = "category"
//   public useStatus: boolean = true
//   public setup(table: Knex.CreateTableBuilder): void {
//     table.string('value').notNullable()
//     table.string('discount_value').nullable()
//     table.string('cost_value').nullable()
//     table.string('tax_value').nullable()
//     // tax
//     table
//       .string('product_id')
//       .references('products.id')
//       .onDelete('CASCADE')
//   }
// }

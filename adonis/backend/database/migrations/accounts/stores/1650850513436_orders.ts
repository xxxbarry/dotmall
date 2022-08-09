import DotBaseSchema from 'Dot/DotBaseSchema'
import { Knex } from 'knex'

export default class Orders extends DotBaseSchema {
  protected tableName = 'orders'
  public useTimestamps = true
  public useSoftDeletes = true
  public useValidatedAt = true
  public setup(table: Knex.CreateTableBuilder): void {
    table.integer('status').defaultTo(0)
    // Events
    table.timestamp('closed_at', { useTz: true })


    table
      .string('address_id')
      .references('addresses.id')
      .onDelete('CASCADE')
    table
      .string('customer_profile_id')
      .references('customer_profiles.id')
      .onDelete('CASCADE')
  }
}

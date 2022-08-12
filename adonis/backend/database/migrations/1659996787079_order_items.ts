
import DotBaseSchema from '../../dot/DotBaseSchema';
import { Knex } from 'knex'
import Product from 'App/Models/accounts/business/stores/Product';
import Order from 'App/Models/Order';

export default class OrderItems extends DotBaseSchema {
  protected tableName = 'order_items'
  public useRelations = [Product, Order]
  public useTimestamps: boolean = false;
  public setup(table: Knex.CreateTableBuilder): void {
    table.integer('quantity').notNullable()
    table.double('price').notNullable()
  }
}

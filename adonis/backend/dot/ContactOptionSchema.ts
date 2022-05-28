import DotBaseSchema from './DotBaseSchema';
import { Knex } from 'knex';

export default class ContactOptionSchema extends DotBaseSchema {
  protected tableName = 'contact_options'
  public useValidatedAt: boolean = true;
  public useUserRelation: boolean = true;
  public useRelatedTo: boolean = true;
  public useTimestamps: boolean = false;
  public setup(_table: Knex.CreateTableBuilder): void {
    // the max length of email is 254
    // table.string('value').notNullable().unique()
    // the type of contact option [email, phone, etc]
    // table.string('type').notNullable()
    // table
    //   .string('related_to')
    //   .references('users.id')
    //   .onDelete('CASCADE') // delete when user is deleted 
  }
}
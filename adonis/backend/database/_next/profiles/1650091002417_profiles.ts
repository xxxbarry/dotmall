// import DotBaseSchema from '../../../dot/DotBaseSchema';
// import { Knex } from 'knex'

// export default class Profiles extends DotBaseSchema {
//   protected tableName = 'profiles'
//   public setup(table: Knex.CreateTableBuilder): void {    
//     // owner
//     table.string('profile_type')
//     table
//       .string('account_id')
//       .references('accounts.id')
//       .onDelete('CASCADE') // delete when account is deleted

//   }
// }

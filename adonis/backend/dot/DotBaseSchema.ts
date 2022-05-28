import BaseSchema from '@ioc:Adonis/Lucid/Schema'
import { Knex } from 'knex';
// define relation Object type
// export class Relation {
//     foreignKey?: string;
//     table: string;
//     column: string;
// }

export default abstract class DotBaseSchema extends BaseSchema {
    // must be implemented
    protected tableName: string;
    public useTimestamps:boolean = true;
    public useSoftDeletes: boolean = false;
    public useValidatedAt: boolean = false;
    public useStatus: boolean = false;
    public useUUID: boolean = true;
    public useRelatedTo: boolean = true;
    public useTranslation: string | null = null;
    
    // List of relations
    // public relations: Relation[] = [];
    // must be implemented
    public abstract setup(table: Knex.CreateTableBuilder): void
    public async up(): Promise<void> {
        this.schema.createTable(this.tableName, (table) => {
            // if (this.useTranslation != null) {
            //     table.string(this.tableName + '_translation_id').references('id').inTable(this.useTranslation + '_translations').onDelete('CASCADE')
            // }
            if (this.useUUID) {
                table.uuid('id').primary();
            } else {
                table.increments('id').primary();
            }

            this.setup(table)
            /*
             * Status
             */
            if (this.useStatus) {
                table.integer('status').notNullable().defaultTo(0);
            }
            /*
             * Validation
             */
            if (this.useValidatedAt) {
                table.timestamp('validated_at').nullable();
            }
            /**
             * Uses timestamptz for PostgreSQL and DATETIME2 for MSSQL
             */
            if (this.useTimestamps) {
                table.timestamp('created_at', { useTz: true })
                table.timestamp('updated_at', { useTz: true })
            }
            /*
             * Soft delete
             */
            if (this.useSoftDeletes) {
                table.timestamp('deleted_at', { useTz: true })
            }
            /*
             * Relations
             */
            if (this.useRelatedTo) {
                table.string('related_to').nullable()
                table.string('related_type').nullable()
            }

        })
    }
    public async down(): Promise<void> {
        this.schema.dropTable(this.tableName)
    }

}

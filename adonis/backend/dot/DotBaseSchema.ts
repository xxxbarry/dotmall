import BaseSchema from '@ioc:Adonis/Lucid/Schema'
import { Knex } from 'knex';
import { string } from '@ioc:Adonis/Core/Helpers'
import { LucidModel } from "@ioc:Adonis/Lucid/Orm";

/**
 * Dot base schema
 * a class with extra methods for defining tables
 * it makes it easier to define tables, use timestamps, soft deletes, etc
 * has a hook like useTimestamps, useSoftDeletes, useRelatedTo, usePivotTable...
 */
export default abstract class DotBaseSchema extends BaseSchema {
  // must be implemented
  protected tableName: string;
  // hooks:
  public useTimestamps: boolean = true;
  public useSoftDeletes: boolean = false;
  public useValidatedAt: boolean = false;
  public useStatus: boolean = false;
  public useUUID: boolean = true;
  public useUserRelation: boolean = false;
  public useRelatedTo: boolean = false;
  public useTranslation: string | null = null;
  public usePivotTable: boolean = false
  public useRelations: Array<LucidModel> = []
  // endHooks

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
        table.uuid('id').primary().unique();
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
      if (this.useRelations.length) {
        this.useRelations.forEach(relation => {
          var tableName = relation.table
          var modelName = string.singularize(tableName)
          var reference = `${tableName}.id`
          var columnName = `${modelName}_id`
          table.uuid(columnName).references(reference).onDelete('CASCADE')
        })
      }

      if (this.useRelatedTo) {
        table.string('related_id').nullable()
        table.string('related_type').nullable()
      }
      if (this.useUserRelation) {
        table.string('user_id').notNullable().references('users.id').onDelete('CASCADE')
      }

    })

    if (this.usePivotTable) {
      this.schema.createTable(this.tableName + '_pivot', (table) => {
        if (this.useUUID) {
          table.uuid('id').primary();
          table.uuid(this.modelName + '_id').references(this.tableName + '.id').onDelete('CASCADE')
          table.uuid('related_id');
        } else {
          table.increments('id').primary();
          table.integer(this.modelName + '_id').unsigned().references(this.tableName + '.id').onDelete('CASCADE')
          table.integer('related_id').unsigned()
        }

        table.string('tag').nullable()
        // fields for meta data
        table.json('meta').nullable()
        table.unique([this.modelName + '_id', 'related_id'])
      }
      )
    }
  }
  public async down(): Promise<void> {
    if (this.usePivotTable) {
      this.schema.dropTable(this.tableName + '_pivot')
    }
    this.schema.dropTable(this.tableName)

  }

  // getter for getting the Model name from the table name
  public get modelName(): string {
    return string.singularize(this.tableName)
  }



}

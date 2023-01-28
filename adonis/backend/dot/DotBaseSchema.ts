import BaseSchema from '@ioc:Adonis/Lucid/Schema'
import { Knex } from 'knex';
import { string } from '@ioc:Adonis/Core/Helpers'
<<<<<<< HEAD
=======
import { LucidModel } from "@ioc:Adonis/Lucid/Orm";

>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
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
<<<<<<< HEAD
  public useRelatedTo: boolean = true;
  public useTranslation: string | null = null;
  public usePivotTable: boolean = false
=======
  public useUserRelation: boolean = false;
  public useRelatedTo: boolean = false;
  public useTranslation: string | null = null;
  public usePivotTable: boolean = false
  public useRelations: Array<LucidModel> = []
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
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
<<<<<<< HEAD
        table.uuid('id').primary();
=======
        table.uuid('id').primary().unique();
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
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
<<<<<<< HEAD
        table.timestamp('created_at', { useTz: true })
        table.timestamp('updated_at', { useTz: true })
=======
        table.timestamp('created_at', { useTz: true }).notNullable().defaultTo(this.now())
        table.timestamp('updated_at', { useTz: true }).notNullable().defaultTo(this.now())
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
      }
      /*
       * Soft delete
       */
      if (this.useSoftDeletes) {
<<<<<<< HEAD
        table.timestamp('deleted_at', { useTz: true })
=======
        table.timestamp('deleted_at', { useTz: true }).nullable()
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
      }
      /*
       * Relations
       */
<<<<<<< HEAD
=======
      if (this.useRelations.length) {
        this.useRelations.forEach(relation => {
          var tableName = relation.table
          var modelName = string.singularize(tableName)
          var reference = `${tableName}.id`
          var columnName = `${modelName}_id`
          table.uuid(columnName).references(reference).onDelete('CASCADE')
        })
      }

>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
      if (this.useRelatedTo) {
        table.string('related_id').nullable()
        table.string('related_type').nullable()
      }
<<<<<<< HEAD
=======
      if (this.useUserRelation) {
        table.string('user_id').notNullable().references('users.id').onDelete('CASCADE')
      }
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

    })

    if (this.usePivotTable) {
      this.schema.createTable(this.tableName + '_pivot', (table) => {
        if (this.useUUID) {
          table.uuid('id').primary();
<<<<<<< HEAD
          table.uuid(this.modelName + '_id').references(this.tableName + '.id')
          table.uuid('related_id');
        } else {
          table.increments('id').primary();
          table.integer(this.modelName + '_id').unsigned().references(this.tableName + '.id')
=======
          table.uuid(this.modelName + '_id').references(this.tableName + '.id').onDelete('CASCADE')
          table.uuid('related_id');
        } else {
          table.increments('id').primary();
          table.integer(this.modelName + '_id').unsigned().references(this.tableName + '.id').onDelete('CASCADE')
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
          table.integer('related_id').unsigned()
        }

        table.string('tag').nullable()
<<<<<<< HEAD
=======
        // fields for meta data
        table.json('meta').nullable()
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
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

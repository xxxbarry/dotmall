// Table
import 'package:auto_sdk_core/auto_sdk_core.dart';

class Table {
  final bool useTranslations;
  final String? name;
  final String? scope;
  final bool? auth;
  const Table(
      {this.auth = false, this.name, this.scope, this.useTranslations = false});
}

// ModelField
class Column<T> {
  final bool primary;
  final bool searchable;
  final bool sortable;
  final bool filterable;
  final bool required;
  final bool translatable;
  final String? behavior;
  final String? behaviorAs;
  final bool? auto;
  final bool? secret;
  final bool? useEnumValue;
  const Column({
    this.useEnumValue = false,
    this.auto = false,
    this.secret = false,
    this.primary = false,
    this.searchable = true,
    this.sortable = true,
    this.filterable = true,
    this.required = false,
    this.behavior = "text",
    this.behaviorAs,
    this.translatable = false,
  });

  // primary factory
  const Column.primary({
    this.useEnumValue = false,
    this.primary = true,
    this.secret = false,
    this.searchable = true,
    this.sortable = true,
    this.filterable = true,
    this.required = false,
    this.behavior = "text",
    this.behaviorAs,
    this.translatable = false,
    this.auto = true,
  });

  // auto construtor
  const Column.auto({
    this.useEnumValue = false,
    this.secret = false,
    this.primary = false,
    this.searchable = true,
    this.sortable = true,
    this.filterable = true,
    this.required = false,
    this.behavior = "text",
    this.behaviorAs,
    this.translatable = false,
    this.auto = true,
  });

  // required factory
  const Column.required({
    this.useEnumValue = false,
    this.secret = false,
    this.primary = false,
    this.searchable = true,
    this.sortable = true,
    this.filterable = true,
    this.required = true,
    this.behavior = "text",
    this.behaviorAs,
    this.translatable = false,
    this.auto = false,
  });
}

enum Behavior { text, file }

//FileField
class FileField {
  final bool required;
  const FileField({
    this.required = false,
  });
}

// Relation
class Relation {
  final String? name;
  final RelationType type;
  final String? foreignKey;
  final String? localKey;
  const Relation({
    this.name,
    required this.type,
    this.foreignKey,
    this.localKey,
  });
}

class HasMany<T extends Model> extends Relation {
  final String from;
  const HasMany({
    super.name,
    super.foreignKey,
    super.localKey,
    super.type = RelationType.hasMany,
    required this.from,
  });
}

class HasOne<T extends Model> extends Relation {
  final String from;
  const HasOne({
    super.name,
    super.foreignKey,
    super.localKey,
    super.type = RelationType.hasOne,
    required this.from,
  });
}

class BelongsTo<T extends Model> extends Relation {
  final String from;
  const BelongsTo({
    super.name,
    super.foreignKey,
    super.localKey,
    super.type = RelationType.belongsTo,
    required this.from,
  });
}

enum RelationType {
  hasOne,
  hasMany,
  belongsTo,
  belongsToMany,
}

// Configure the generator
class ModelConfig {
  final String? table;
  final String? model;
  final List<Column> columns;
  const ModelConfig({
    this.table,
    this.model,
    required this.columns,
  }) : assert(table != null || model != null);
}

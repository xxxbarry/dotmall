import 'package:code_builder/code_builder.dart' as cb;
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:inflection3/inflection3.dart';
import 'package:recase/recase.dart';

class Generator {
  static String generate({
    String? name,
    required String table,
    required List<Field> fields,
  }) {
    name = name ?? singularize(table).pascalCase;
    final model = cb.Class(
      (c) => c
        ..name = name
        ..extend = cb.refer('Model')
        ..fields.addAll([
          cb.Field(
            (f) => f
              ..name = 'table'
              ..type = refer('String')
              ..modifier = FieldModifier.constant
              ..assignment = Code("'$table'")
              ..static = true,
          ),
          ...fields.map(
            (field) => field.toClassField(),
          ),
        ]),
    );
    return DartFormatter().format(model.accept(DartEmitter()).toString());
  }
}

class Field {
  final String name;
  final bool primary;
  final bool nullable;
  final bool searchable;
  final bool sortable;
  final bool filterable;
  final FieldType type;
  Field(
    this.name, {
    this.primary = false,
    this.nullable = false,
    this.searchable = true,
    this.sortable = true,
    this.filterable = true,
    this.type = FieldType.string,
  });

  /// [Field.text] factory method.
  /// Returns a [Field] with [FieldType.text].
  factory Field.text(
    String name, {
    bool primary = false,
    bool nullable = true,
    bool searchable = true,
    bool sortable = false,
    bool filterable = false,
  }) {
    return Field(
      name,
      primary: primary,
      nullable: nullable,
      searchable: searchable,
      sortable: sortable,
      filterable: filterable,
      type: FieldType.text,
    );
  }

  /// [Field.datetime] factory method.
  /// Returns a [Field] with [FieldType.datetime].
  factory Field.datetime(
    String name, {
    bool primary = false,
    bool nullable = true,
    bool searchable = true,
    bool sortable = true,
    bool filterable = true,
  }) {
    return Field(
      name,
      primary: primary,
      nullable: nullable,
      searchable: searchable,
      sortable: sortable,
      filterable: filterable,
      type: FieldType.datetime,
    );
  }

  // typeReference
  cb.Reference get typeReference {
    String reftype = "";
    switch (type) {
      case FieldType.string:
        reftype = "String";
        break;
      case FieldType.text:
        reftype = "String";
        break;
      case FieldType.datetime:
        reftype = "DateTime";
        break;
      case FieldType.integer:
        reftype = "int";
        break;
      case FieldType.double:
        reftype = "double";
        break;
      case FieldType.boolean:
        reftype = "bool";
        break;
      default:
        reftype = "String";
        break;
    }
    if (nullable) {
      reftype += "?";
    }
    return cb.Reference(reftype);
  }

  // toClassField
  cb.Field toClassField() {
    return cb.Field(
      (f) => f
        ..name = name
        ..type = typeReference
        ..modifier = cb.FieldModifier.final$,
    );
  }
}

enum FieldType {
  string,
  text,
  integer,
  double,
  boolean,
  date,
  datetime,
  time,
  timestamp,
  json,
  enums,
  object,
}

import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:annotations/annotations.dart';
import 'package:build/src/builder/build_step.dart';
import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/type.dart';

import 'package:analyzer/dart/constant/value.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:inflection3/inflection3.dart';
import 'package:source_gen/source_gen.dart';
import 'package:recase/recase.dart';

class TableAnnotationGenerator extends GeneratorForAnnotation<Table> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    var visitor = ModelVisitor();
    element.visitChildren(visitor);
    // table field from annotation and its optionald
    var table = annotation.objectValue.getField('table')?.toStringValue();
    var scope = annotation.objectValue.getField('scope')?.toStringValue();
    var auth = annotation.objectValue.getField('auth')?.toBoolValue() ?? false;
    var useTranslations =
        annotation.objectValue.getField('useTranslations')?.toBoolValue() ??
            false;
    var className = element.displayName;
    var tableName = table ?? pluralize(className).snakeCase;
    var pluralClassName = pluralize(className.snakeCase).pascalCase;
    var scopeName = scope ?? pluralize(className).snakeCase;
    // relations is fields that are used to define the relations of the model.
    Enum? modelRelations;
    Enum? modelFields;
    Enum? modelSearchables;
    Enum? modelSortables;
    Enum? modelFilterables;
    Enum? modelTranslatables;
    Class? modelAuthCredentials;

    if (visitor.fields.isNotEmpty) {
      modelFields = Enum(
        (e) => e
          ..name = '${className}Fields'
          ..values.addAll([
            //EnumValue((ev) => ev..name = "_"),
            ...visitor.columns.keys.map((f) => EnumValue((ev) => ev..name = f))
          ]),
      );
      var _modelSearchables = [];
      var _modelSortables = [];
      var _modelFilterables = [];
      var _modelTranslatables = [];

      for (var field in visitor.fields) {
        var sortable =
            visitor.columns[field.name]?.getField("sortable")?.toBoolValue() ??
                false;
        var searchable = visitor.columns[field.name]
                ?.getField("searchable")
                ?.toBoolValue() ??
            false;
        var filterable = visitor.columns[field.name]
                ?.getField("filterable")
                ?.toBoolValue() ??
            false;
        var translatable = visitor.columns[field.name]
                ?.getField("translatable")
                ?.toBoolValue() ??
            false;

        if (sortable) {
          _modelSortables.add(field.name);
        }
        if (searchable) {
          _modelSearchables.add(field.name);
        }
        if (filterable) {
          _modelFilterables.add(field.name);
        }
        if (translatable) {
          _modelTranslatables.add(field.name);
        }
      }
      if (_modelFilterables.isNotEmpty) {
        modelFilterables = Enum(
          (e) => e
            ..name = '${className}Filterables'
            ..values.addAll([
              //EnumValue((ev) => ev..name = "_"),
              ..._modelFilterables.map((f) => EnumValue((ev) => ev..name = f))
            ]),
        );
      }
      if (_modelSortables.isNotEmpty) {
        modelSortables = Enum(
          (e) => e
            ..name = '${className}Sortables'
            ..values.addAll([
              //EnumValue((ev) => ev..name = "_"),
              ..._modelSortables.map((f) => EnumValue((ev) => ev..name = f))
            ]),
        );
      }
      if (_modelSearchables.isNotEmpty) {
        modelSearchables = Enum(
          (e) => e
            ..name = '${className}Searchables'
            ..values.addAll([
              //EnumValue((ev) => ev..name = "_"),
              ..._modelSearchables.map((f) => EnumValue((ev) => ev..name = f))
            ]),
        );
      }
      if (_modelTranslatables.isNotEmpty) {
        modelTranslatables = Enum(
          (e) => e
            ..name = '${className}Translatables'
            ..values.addAll([
              //EnumValue((ev) => ev..name = "_"),
              ..._modelTranslatables.map((f) => EnumValue((ev) => ev..name = f))
            ]),
        );
      }
      if (visitor.relations.isNotEmpty) {
        modelRelations = Enum(
          (e) => e
            ..name = '${className}Relations'
            ..values.addAll([
              //EnumValue((ev) => ev..name = "_"),
              ...visitor.relations.keys
                  .map((key) => EnumValue((ev) => ev..name = key))
            ]),
        );
      }
    }

    if (auth) {
      modelAuthCredentials = Class((c) => c
        ..name = "${className}AuthCredentials"
        ..extend = refer("AuthCredentials<String,String>")
        ..constructors.add(Constructor((c) => c
          ..constant = true
          ..optionalParameters.addAll([
            Parameter((p) => p
              ..name = "username"
              ..named = true
              ..required = true
              ..toSuper = true),
            Parameter((p) => p
              ..name = "password"
              ..named = true
              ..required = true
              ..toSuper = true)
          ]))));
    }

    // TODO: add automatic generation of translation model
    // if (useTranslations) {
    //   var modelTranslations = Class((c) => c
    //     ..name = '${className}Translations'
    //     ..extend = refer('ModelTranslations')
    //     ..fields.addAll([]));
    // }

    // createTranslations()

    var collectionClass = Class((c) => c
      ..name = pluralClassName
      ..extend = auth
          ? refer('AuthCollection<${className},${className}AuthCredentials>')
          : refer('Collection<${className}>')
      ..constructors.addAll([
        Constructor((cn) => cn
          ..requiredParameters.addAll([
            Parameter((p) => p
              ..name = 'manager'
              ..toThis = true),
          ])),
      ])
      ..fields.addAll([
        Field((f) => f
          ..name = 'manager'
          ..modifier = FieldModifier.final$
          ..type = refer('Manager')),
        Field((f) => f
          ..name = 'table'
          ..modifier = FieldModifier.final$
          ..assignment = Code('"$tableName"')
          ..type = refer('String')),
        Field((f) => f
          ..name = 'scope'
          ..modifier = FieldModifier.final$
          ..assignment = Code('"$scopeName"')
          ..type = refer('String')),
      ])
      ..methods.addAll([
        if (auth) ...[
          Method((m) => m
            ..name = 'signin'
            ..modifier = MethodModifier.async
            ..returns = refer('Future<AuthResponse<${className}>>')
            ..optionalParameters.addAll([
              Parameter((p) => p
                ..name = 'credentials'
                ..required = true
                ..named = true
                ..type = refer('${className}AuthCredentials')),
              Parameter(
                (p) => p
                  ..name = 'options'
                  ..named = true
                  ..type = refer('RequestOptions?'),
              )
            ])
            ..body = Code('''

    options = options ?? RequestOptions();
    var response = await signinR(
      options: options.copyWithAdded(data: credentials.toMap()),
    );
    
    return AuthResponse<$className>(
      model: modelFromMap(response.data!["${singularize(className).toLowerCase()}"]),
      token: Token.fromMap(response.data!["token"]),
    );
''')),
          Method((m) => m
            ..name = 'auth'
            ..modifier = MethodModifier.async
            ..returns = refer('Future<$className>')
            ..optionalParameters.addAll([
              Parameter(
                (p) => p
                  ..name = 'options'
                  ..named = true
                  ..type = refer('RequestOptions?'),
              )
            ])
            ..body = Code('''

    options = options ?? RequestOptions();
    var response = await authR(options: options);

    return modelFromMap(response.data!["${singularize(className).toLowerCase()}"]);
''')),
          Method((m) => m
            ..name = 'signout'
            ..modifier = MethodModifier.async
            ..returns = refer('Future<void>')
            ..optionalParameters.addAll([
              Parameter((p) => p
                ..name = 'options'
                ..named = true
                ..type = refer('RequestOptions?')),
            ])
            ..body = Code('''
    options = options ?? RequestOptions();
    await signoutR(
      options: options,
    );
    ''')),
          Method((m) => m
            ..name = 'signup'
            ..modifier = MethodModifier.async
            ..returns = refer('Future<AuthResponse<$className>>')
            ..optionalParameters.addAll([
              Parameter((p) => p
                ..name = 'credentials'
                ..required = true
                ..named = true
                ..type = refer('${className}AuthCredentials')),
              Parameter((p) => p
                ..name = 'options'
                ..named = true
                ..type = refer('RequestOptions?')),
            ])
            ..body = Code('''
    options = options ?? RequestOptions();
    var response = await signupR(
      options: options.copyWithAdded(data: {
        ...?options.data,
        ...credentials.toMap(),
      }),
    );
    return AuthResponse<$className>(
      model: modelFromMap(response.data!["${singularize(className).toLowerCase()}"]),
      token: Token.fromMap(response.data!["token"]),
    );
''')),
        ],
        Method(
          (cn) => cn
            ..name = 'modelFromMap'
            ..requiredParameters.addAll(
              [
                Parameter(
                  (p) => p
                    ..name = 'map'
                    ..type = refer('Map<String, dynamic>'),
                ),
              ],
            )
            ..static = true
            ..returns = refer(className)
            ..body = Code(
              '''
              return $className(${() {
                var init = '';
                for (var key in visitor.columns.keys) {
                  var typeWithNullability =
                      "${visitor.fields.firstWhere((e) => e.name == key).type.getDisplayString(withNullability: true)}";
                  var typeWithoutNullability =
                      "${visitor.fields.firstWhere((e) => e.name == key).type.getDisplayString(withNullability: false)}";
                  //
                  bool isEnum = visitor.fields
                      .firstWhere((e) => e.name == key)
                      .type
                      .allSupertypes
                      .where((e) => e.name == "Enum")
                      .toList()
                      .isNotEmpty;

                  if (typeWithNullability == 'DateTime?') {
                    init +=
                        '${key.camelCase}: DateTime.tryParse(map["${key.snakeCase}"] ?? ""),\n';
                  } else if (typeWithoutNullability == 'DateTime') {
                    init +=
                        '${key.camelCase}: DateTime.parse(map["${key.snakeCase}"]),\n';
                  } else if (isEnum) {
                    init +=
                        '${key.camelCase}:$typeWithoutNullability.values.firstWhere((e) => e.name == map["${key.snakeCase}"]),';
                  } else {
                    init += '${key.camelCase}: map["${key.snakeCase}"],\n';
                  }
                }
                for (var key in visitor.relations.keys) {
                  init += '''${key.camelCase}: [${() {
                    var init = '';
                    var field = visitor.fields.firstWhere((e) => e.name == key);
                    var anotation = visitor.relations[key];
                    var val = anotation?.getField("from")?.toStringValue();
                    var hasMany = visitor.fields
                        .firstWhere((e) {
                          return e.displayName == key;
                        })
                        .metadata
                        .firstWhere((e) => e.element?.displayName == 'HasMany');
                    if (hasMany != null) {
                      init += '''
                           for (var item in map["${key.snakeCase}"]  ?? [])
                             ${pluralize(val!).pascalCase}.modelFromMap(item),
                        ''';
                    }
                    // init += '${an}, ';
                    return init;
                  }()}],\n''';
                }
                return init;
              }()});
              ''',
            ),
        ),
        Method(
          (cn) => cn
            ..name = 'modelToMap'
            ..requiredParameters.addAll(
              [
                Parameter(
                  (p) => p
                    ..name = className.toLowerCase()
                    ..type = refer(className),
                ),
              ],
            )
            ..static = true
            ..returns = refer('Map<String, dynamic>')
            ..body = Code(
              '''
              return {${() {
                var init = '';
                for (var key in visitor.columns.keys) {
                  bool isEnum = visitor.fields
                      .firstWhere((e) => e.name == key)
                      .type
                      .allSupertypes
                      .where((e) => e.name == "Enum")
                      .toList()
                      .isNotEmpty;
                  if (isEnum) {
                    init +=
                        '"${key.snakeCase}": ${className.toLowerCase()}.${key.camelCase}.name,\n';
                  } else {
                    init +=
                        '"${key.snakeCase}": ${className.toLowerCase()}.$key,\n';
                  }
                }
                for (var key in visitor.relations.keys) {
                  init += '''"${key.snakeCase}":
                    ${className.toLowerCase()}.$key
                      .map((item) => item.toMap()).toList()
                  ,\n''';
                }
                return init;
              }()}};
              ''',
            ),
        ),
        Method(
          (m) => m
            ..name = 'find'
            ..modifier = MethodModifier.async
            ..returns = refer('Future<$className>')
            ..requiredParameters.addAll([
              Parameter((p) => p
                ..name = 'id'
                ..type = refer('String')),
            ])
            ..optionalParameters.addAll([
              if (modelRelations != null)
                Parameter((p) => p
                  ..name = 'load'
                  ..named = true
                  ..type = refer('List<${className}Relations>?')),
              Parameter((p) => p
                ..name = 'options'
                ..named = true
                ..type = refer('RequestOptions?')),
            ])
            ..body = Code(
              '''
              try {options = options ?? RequestOptions();
              var response = await findR(
                id,
                options: options.copyWithAdded(
                  queryParameters: {${modelRelations != null ? "'load': load?.map((e) => e.name).toList()," : ""}},
                ),
              );
              return modelFromMap(response.data!["${className.snakeCase}"]);
              
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
              ''',
            ),
        ),

        Method(
          (m) => m
            ..name = 'delete'
            ..modifier = MethodModifier.async
            ..returns = refer('Future<void>')
            ..requiredParameters.addAll([
              Parameter((p) => p
                ..name = 'id'
                ..type = refer('String')),
            ])
            ..optionalParameters.addAll([
              if (modelRelations != null)
                Parameter((p) => p
                  ..name = 'load'
                  ..named = true
                  ..type = refer('List<${className}Relations>?')),
              Parameter((p) => p
                ..name = 'options'
                ..named = true
                ..type = refer('RequestOptions?')),
            ])
            ..body = Code(
              '''try {
                options = options ?? RequestOptions();
              var response = await findR(
                id,
                options: options,
              );
                        
              } on DioError catch (e) {
                if (e.response?.statusCode == 422 && e.response != null) {
                  throw ValidationException.fromMap(e.response?.data);
                } else {
                  rethrow;
                }
              }
              ''',
            ),
        ),
        // create
        Method(
          (m) => m
            ..name = 'create'
            ..modifier = MethodModifier.async
            ..returns = refer('Future<$className>')
            ..optionalParameters.addAll([
              ...(() {
                var list = [];
                for (var key in visitor.columns.keys) {
                  var auto =
                      visitor.columns[key]?.getField("auto")?.toBoolValue() ??
                          false;
                  if (auto) {
                    continue;
                  }
                  var required = visitor.columns[key]
                          ?.getField("required")
                          ?.toBoolValue() ??
                      false;
                  var behavior = visitor.columns[key]
                      ?.getField("behavior")
                      ?.toStringValue();

                  Reference type;
                  if (behavior == "file") {
                    key = visitor.columns[key]
                            ?.getField("behaviorAs")
                            ?.toStringValue() ??
                        key;
                    type = refer("MultipartFile");
                  } else {
                    type = refer(visitor.fields
                        .firstWhere((e) => e.name == key)
                        .type
                        .getDisplayString(withNullability: true));
                  }

                  list.add(Parameter((p) => p
                    ..name = key
                    ..required = type.toString().contains('?') ? required : true
                    ..type = type));
                }
                return list;
              })(),
              Parameter((p) => p
                ..name = 'options'
                ..named = true
                ..type = refer('RequestOptions?')),
            ])
            ..body = Code(
              '''
              try {
              options = options ?? RequestOptions();
              var response = await createR(
                options: options.copyWithAdded(
                  data: {
                    ${visitor.columns.keys.where((key) {
                return !(visitor.columns[key]
                        ?.getField("auto")
                        ?.toBoolValue() ??
                    false);
              }).map((key) {
                bool isEnum = visitor.fields
                    .firstWhere((e) => e.name == key)
                    .type
                    .allSupertypes
                    .where((e) => e.name == "Enum")
                    .toList()
                    .isNotEmpty;
                var behaviorAs = visitor.columns[key]
                    ?.getField("behaviorAs")
                    ?.toStringValue();
                if (isEnum) {
                  return "if (${(behaviorAs ?? key)} != null) '${(behaviorAs ?? key).snakeCase}': ${(behaviorAs ?? key)}.name";
                } else {
                  return "if (${(behaviorAs ?? key)} != null) '${(behaviorAs ?? key).snakeCase}': ${(behaviorAs ?? key)}";
                }
              }).join(', ')},
                }),
              );
              return modelFromMap(response.data!["${className.snakeCase}"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
              ''',
            ),
        ),
        // create
        Method(
          (m) => m
            ..name = 'update'
            ..modifier = MethodModifier.async
            ..returns = refer('Future<$className>')
            ..requiredParameters.addAll([
              Parameter((p) => p
                ..name = 'id'
                ..type = refer('String')),
            ])
            ..optionalParameters.addAll([
              ...(() {
                var list = [];
                for (var key in visitor.columns.keys.where((e) => e != 'id')) {
                  var behavior = visitor.columns[key]
                      ?.getField("behavior")
                      ?.toStringValue();
                  Reference type;
                  if (behavior == "file") {
                    key = visitor.columns[key]
                            ?.getField("behaviorAs")
                            ?.toStringValue() ??
                        key;
                    type = refer("MultipartFile?");
                  } else {
                    type = refer(
                        "${visitor.fields.firstWhere((e) => e.name == key).type.getDisplayString(withNullability: false)}?");
                  }

                  list.add(Parameter((p) => p
                    ..name = key
                    ..required = false
                    ..type = type));
                }
                return list;
              })(),
              Parameter((p) => p
                ..name = 'options'
                ..named = true
                ..type = refer('RequestOptions?')),
            ])
            ..body = Code(
              '''try {
                options = options ?? RequestOptions();
              var response = await updateR(
                id,
                options: options.copyWithAdded(
                  data: {
                    ${visitor.columns.keys.where((e) => e != 'id').map((key) {
                bool isEnum = visitor.fields
                    .firstWhere((e) => e.name == key)
                    .type
                    .allSupertypes
                    .where((e) => e.name == "Enum")
                    .toList()
                    .isNotEmpty;
                var behaviorAs = visitor.columns[key]
                    ?.getField("behaviorAs")
                    ?.toStringValue();
                if (isEnum) {
                  return "if (${(behaviorAs ?? key)} != null) '${(behaviorAs ?? key).snakeCase}': ${(behaviorAs ?? key)}.name";
                } else {
                  return "if (${(behaviorAs ?? key)} != null) '${(behaviorAs ?? key).snakeCase}': ${(behaviorAs ?? key)}";
                }
              }).join(', ')}
                  },
                ),
              );
              return modelFromMap(response.data!["${className.snakeCase}"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
              ''',
            ),
        ),
        // list
        Method(
          (m) => m
            ..name = 'list'
            ..modifier = MethodModifier.async
            ..returns = refer('Future<Paginated$className>')
            ..optionalParameters.addAll([
              if (modelRelations != null)
                Parameter((p) => p
                  ..name = 'load'
                  ..named = true
                  ..type = refer('List<${className}Relations>?')),
              // page defaults to 1
              Parameter((p) => p
                ..name = 'page'
                ..named = true
                ..type = refer('int?')
                ..defaultTo = Code('1')),
              //limit defaults to 24
              Parameter((p) => p
                ..name = 'limit'
                ..named = true
                ..type = refer('int?')
                ..defaultTo = Code('24')),
              // sort is enum of ${className}Sortables
              if (modelSortables != null)
                Parameter((p) => p
                  ..name = 'sort'
                  ..named = true
                  ..type = refer('${className}Sortables?')),
              // order is enum of Order
              if (modelSortables != null)
                Parameter((p) => p
                  ..name = 'order'
                  ..named = true
                  ..type = refer('SortOrder?')),
              // search is a string
              if (modelSearchables != null)
                Parameter((p) => p
                  ..name = 'search'
                  ..named = true
                  ..type = refer('String?')),
              // searchIn is enum of ${className}Searchables
              if (modelSearchables != null)
                Parameter((p) => p
                  ..name = 'searchIn'
                  ..named = true
                  ..type = refer('${className}Searchables?')),
              // where is a map of ${className}Field enum to value
              if (modelFilterables != null)
                Parameter((p) => p
                  ..name = 'where'
                  ..named = true
                  ..type = refer('Map<${className}Fields, String>?')),
              Parameter((p) => p
                ..name = 'options'
                ..named = true
                ..type = refer('RequestOptions?')),
            ])
            ..body = Code(
              '''
              try {
              ${modelSearchables != null ? "assert((search == null && searchIn == null) ||(search != null && searchIn != null),'search and searchIn must be used together');" : ""}
              options = options ?? RequestOptions();
              var response = await listR(
                  options: options.copyWithAdded(queryParameters: {
                if (page != null) 'page': page.toString(),
                if (limit != null) 'limit': limit.toString(),
                ${modelSearchables != null ? "if (sort != null) 'sort': sort.name," : ""}
                ${modelSearchables != null ? "if (order != null) 'order': order.name," : ""}
                ${modelSearchables != null ? "if (search != null) 'search': search," : ""}
                ${modelSearchables != null ? "if (searchIn != null) 'searchIn': searchIn.name," : ""}
                // [where] is a map of [${className}Fields] and [String], it should convert to a map of [String] and [String].
                ${modelFilterables != null ? "if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v))," : ""}
                ${modelRelations != null ? "if (load != null) 'load': load.map((e) => e.name).toList()" : ""}
              }));
              return Paginated${className}.fromMap(response.data!);
              
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
              ''',
            ),
        ),
        // relations
        ...(() {
          var _methods = <Method>[];
          for (var key in visitor.relations.keys) {
            var field = visitor.fields.firstWhere((e) => e.name == key);
            var anotation = visitor.relations[key];
            var val = anotation?.getField("from")?.toStringValue();
            var hasMany = visitor.fields
                .firstWhere((e) {
                  return e.displayName == key;
                })
                .metadata
                .firstWhere((e) => e.element?.displayName == 'HasMany');
            if (hasMany != null) {
              _methods.add(
                Method(
                  (m) => m
                    ..name = pluralize(key).snakeCase
                    ..returns = refer(pluralize(val!).pascalCase)
                    ..optionalParameters.addAll([
                      Parameter((p) => p
                        ..name = 'options'
                        ..named = true
                        ..type = refer('RequestOptions?')),
                    ])
                    ..body = Code(
                        '''return ${pluralize(val).pascalCase}(manager);'''),
                ),
              );
            }
          }
          ;
          return _methods;
        })(),
      ]));
    var paginatedModel = Class(
      (c) => c
        ..name = 'Paginated$className'
        ..extend = refer('PaginatedModel')
        ..constructors.add(
          Constructor((c) => c
            ..optionalParameters.addAll([
              Parameter((p) => p
                ..name = 'data'
                ..required = true
                ..named = true
                ..toThis = true),
              Parameter((p) => p
                ..name = 'meta'
                ..required = true
                ..named = true
                ..toThis = true),
            ])),
        )
        ..fields.addAll([
          Field((f) => f
            ..name = 'data'
            ..type = refer('List<$className>')
            ..modifier = FieldModifier.final$),
          Field((f) => f
            ..name = 'meta'
            ..type = refer('PaginationMeta')
            ..modifier = FieldModifier.final$),
        ])
        ..methods.addAll([
          Method(
            (m) => m
              ..name = 'fromMap'
              ..static = true
              ..requiredParameters.addAll(
                [
                  Parameter(
                    (p) => p
                      ..name = 'map'
                      ..type = refer('Map<String, dynamic>'),
                  ),
                ],
              )
              ..returns = refer('Paginated$className')
              ..body = Code(
                '''
              return Paginated$className(
                data: List<$className>.from(map['data'].map((x) => $className.fromMap(x))),
                meta: PaginationMeta.fromMap(map['meta']),
              );
              ''',
              ),
          ),
        ]),
    );
    var buffer = StringBuffer();
    buffer.writeln('''
      // ${pluralize(className).pascalCase}
      ${DartFormatter().format('${collectionClass.accept(DartEmitter())}')}
      // ${className}Relations
      ${modelRelations != null ? DartFormatter().format('${modelRelations.accept(DartEmitter())}') : "// no relations"}
      // ${className}Filterables
      ${modelFilterables != null ? DartFormatter().format('${modelFilterables.accept(DartEmitter())}') : "// no filterable fields"}
      // ${className}Sortables
      ${modelSortables != null ? DartFormatter().format('${modelSortables.accept(DartEmitter())}') : "// no sortable fields"}
      // ${className}Searchables
      ${modelSearchables != null ? DartFormatter().format('${modelSearchables.accept(DartEmitter())}') : "// no searchable fields"}
      // ${className}Fields
      ${modelFields != null ? DartFormatter().format('${modelFields.accept(DartEmitter())}') : "// no fields"}
      // ${className}Translatables
      ${modelTranslatables != null ? DartFormatter().format('${modelTranslatables.accept(DartEmitter())}') : "// no fields"}
      // ${className}AuthCredentials
      ${modelAuthCredentials != null ? DartFormatter().format('${modelAuthCredentials.accept(DartEmitter())}') : "// no fields"}
      // Paginated${className}
      ${DartFormatter().format('${paginatedModel.accept(DartEmitter())}')}
      ''');

    return buffer.toString();
  }
}

class ModelVisitor extends SimpleElementVisitor {
  DartType? className;
  List<dynamic> fields = [];
  Map<String, DartObject?> columns = {};
  Map<String, DartObject?> relations = {};

  @override
  visitConstructorElement(ConstructorElement element) {
    className = element.type.returnType;
  }

  @override
  visitFieldElement(FieldElement element) {
    fields.add(element);
    var column = getAnnotation<Column>(element);
    var relation = getAnnotation<Relation>(element);

    if (column != null) {
      columns[element.name] = column;
    }
    if (relation != null) {
      relations[element.name] = relation;
    }
  }

  DartObject? getAnnotation<T>(Element element) {
    final annotations = TypeChecker.fromRuntime(T).annotationsOf(element);
    if (annotations.isEmpty) {
      return null;
    }
    if (annotations.length > 1) {
      throw Exception("You tried to add multiple @$T() annotations to the "
          "same element (${element.name}), but that's not possible.");
    }
    return annotations.single;
  }
}

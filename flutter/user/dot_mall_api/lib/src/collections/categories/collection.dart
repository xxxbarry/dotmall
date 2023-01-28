import 'dart:convert';

import 'package:dio/dio.dart' show MultipartFile;

import '../../dot_mall_api_base.dart';
import '../collection.dart';
import '../model.dart';
import 'model.dart';

/// [CategoryRelations] enum is used to define the relations of the model.
enum CategoryRelations implements ModelRelations {
  // stores,
  photos,
}

/// [CategoryFields] enum is used to define the fields of the model.
enum CategoryFields implements ModelFields {
  id,
  name,
  description,
  createdAt,
  updatedAt,
}

/// [Categories] is a class extends [Collection],
/// it is used to manage the categories.
class Categories extends Collection with TimestampMixin {
  Categories(this.manager);
  @override
  final Manager manager;
  @override
  String get scope => 'categories';

  /// [find] is used to find a category by id.
  Future<Category> find(String id,
      {List<CategoryRelations>? load, RequestOptions? options}) async {
    options = options ?? RequestOptions();
    var response = await findR(id,
        options: options.copyWithAdded(
            queryParameters: {'load': load?.map((e) => e.name).toList()}));
    return Category.fromMap(response.data!);
  }

  /// [list] is used to list all categories.
  Future<PaginatedCategory> list(
      {List<CategoryRelations>? load,
      int? page = 1,
      int? limit,
      CategoryFields? sort,
      SortOrder? order,
      String? search,
      CategoryFields? searchIn,
      Map<CategoryFields, String>? where,
      RequestOptions? options}) async {
    assert(
        (search == null && searchIn == null) ||
            (search != null && searchIn != null),
        'search and searchIn must be used together');
    options = options ?? RequestOptions();
    var response = await listR(
        options: options.copyWithAdded(queryParameters: {
      if (page != null) 'page': page.toString(),
      if (limit != null) 'limit': limit.toString(),
      if (sort != null) 'sort': sort.name,
      if (order != null) 'order': order.name,
      if (search != null) 'search': search,
      if (searchIn != null) 'searchIn': searchIn.name,
      // [where] is a map of [CategoryFields] and [String], it should convert to a map of [String] and [String].
      if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
      if (load != null) 'load': load.map((e) => e.name).toList(),
    }));
    return PaginatedCategory.fromMap(response.data!);
  }

  /// [create] is used to create a new category.
  Future<Category> create({
    required String name,
    String? description,
    MultipartFile? photo,
    RequestOptions? options,
  }) async {
    options = options ?? RequestOptions();
    var response = await createR(
      options: options.copyWithAdded(
        data: {
          'name': name,
          if (description != null) 'description': description,
          if (photo != null) 'photo': photo,
        },
      ),
    );
    return Category.fromMap(response.data!);
  }

  /// [update] is used to update a category.
  Future<Category> update(
    String id, {
    String? name,
    String? description,
    MultipartFile? photo,
    RequestOptions? options,
  }) async {
    options = options ?? RequestOptions();
    var response = await updateR(
      id,
      options: options.copyWithAdded(
        data: {
          if (name != null) 'name': name,
          if (description != null) 'description': description,
          if (photo != null) 'photo': photo,
        },
      ),
    );
    return Category.fromMap(response.data!);
  }

  /// [delete] is used to delete a category.
  Future<void> delete(String id, {RequestOptions? options}) async {
    await deleteR(id, options: options);
  }
}

class PaginatedCategory extends PaginatedModel {
  @override
  final List<Category> data;
  @override
  final PaginationMeta meta;
  PaginatedCategory({
    required this.data,
    required this.meta,
  });

  PaginatedCategory copyWith({
    List<Category>? data,
    PaginationMeta? meta,
  }) {
    return PaginatedCategory(
      data: data ?? this.data,
      meta: meta ?? this.meta,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((x) => x.toMap()).toList(),
      'meta': meta.toMap(),
    };
  }

  factory PaginatedCategory.fromMap(Map<String, dynamic> map) {
    return PaginatedCategory(
      data: List<Category>.from(map['data'].map((x) => Category.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginatedCategory.fromJson(String source) =>
      PaginatedCategory.fromMap(json.decode(source));

  @override
  String toString() => 'PaginatedCategory(data: $data, meta: $meta)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaginatedCategory &&
        // listEquals(other.data, data) &&
        other.meta == meta;
  }

  @override
  int get hashCode => data.hashCode ^ meta.hashCode;
}

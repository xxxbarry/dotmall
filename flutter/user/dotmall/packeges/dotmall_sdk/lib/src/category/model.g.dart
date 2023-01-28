// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TableAnnotationGenerator
// **************************************************************************

// Categories
class Categories extends Collection<Category> {
  Categories(this.manager);

  final Manager manager;

  final String table = "categories";

  final String scope = "categories";

  static Category modelFromMap(Map<String, dynamic> map) {
    return Category(
      id: map["id"],
      name: map["name"],
      description: map["description"],
      slug: map["slug"],
      photos: [for (var item in map["photos"] ?? []) Files.modelFromMap(item)],
      translations: [
        for (var item in map["translations"] ?? [])
          CategoryTranslations.modelFromMap(item)
      ],
    );
  }

  static Map<String, dynamic> modelToMap(Category category) {
    return {
      "id": category.id,
      "name": category.name,
      "description": category.description,
      "slug": category.slug,
      "photos": [for (var item in category.photos ?? []) item.modelToMap()],
      "translations": [
        for (var item in category.translations ?? []) item.modelToMap()
      ],
    };
  }

  Future<Category> find(String id,
      {List<CategoryRelations>? load, RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await findR(
        id,
        options: options.copyWithAdded(
          queryParameters: {
            'load': load?.map((e) => e.name).toList(),
          },
        ),
      );
      return modelFromMap(response.data!["category"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<void> delete(String id,
      {List<CategoryRelations>? load, RequestOptions? options}) async {
    try {
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
  }

  Future<Category> create(
      {required String name,
      String? description,
      String? slug,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await createR(
        options: options.copyWithAdded(data: {
          if (name != null) 'name': name,
          if (description != null) 'description': description,
          if (slug != null) 'slug': slug,
        }),
      );
      return modelFromMap(response.data!["category"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<Category> update(String id,
      {String? name,
      String? description,
      String? slug,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await updateR(
        id,
        options: options.copyWithAdded(
          data: {
            if (name != null) 'name': name,
            if (description != null) 'description': description,
            if (slug != null) 'slug': slug
          },
        ),
      );
      return modelFromMap(response.data!["category"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<PaginatedCategory> list(
      {List<CategoryRelations>? load,
      int? page = 1,
      int? limit = 24,
      CategorySortables? sort,
      SortOrder? order,
      String? search,
      CategorySearchables? searchIn,
      Map<CategoryFields, String>? where,
      RequestOptions? options}) async {
    try {
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
        if (load != null) 'load': load.map((e) => e.name).toList()
      }));
      return PaginatedCategory.fromMap(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }
}

// CategoryRelations
enum CategoryRelations { photos, translations }

// CategoryFilterables
enum CategoryFilterables { id, name, description, slug }

// CategorySortables
enum CategorySortables { id, name, description, slug }

// CategorySearchables
enum CategorySearchables { id, name, description, slug }

// CategoryFields
enum CategoryFields { id, name, description, slug }

// CategoryTranslatables
// no fields
// CategoryAuthCredentials
// no fields
// PaginatedCategory
class PaginatedCategory extends PaginatedModel {
  PaginatedCategory({required this.data, required this.meta});

  final List<Category> data;

  final PaginationMeta meta;

  static PaginatedCategory fromMap(Map<String, dynamic> map) {
    return PaginatedCategory(
      data: List<Category>.from(map['data'].map((x) => Category.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }
}

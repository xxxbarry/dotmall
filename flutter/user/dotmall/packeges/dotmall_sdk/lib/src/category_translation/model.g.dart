// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TableAnnotationGenerator
// **************************************************************************

// CategoryTranslations
class CategoryTranslations extends Collection<CategoryTranslation> {
  CategoryTranslations(this.manager);

  final Manager manager;

  final String table = "category_translations";

  final String scope = "category_translations";

  static CategoryTranslation modelFromMap(Map<String, dynamic> map) {
    return CategoryTranslation(
      id: map["id"],
      locale: Languages.values.firstWhere((e) => e.name == map["locale"]),
      name: map["name"],
      description: map["description"],
      categoryId: map["category_id"],
    );
  }

  static Map<String, dynamic> modelToMap(
      CategoryTranslation categorytranslation) {
    return {
      "id": categorytranslation.id,
      "locale": categorytranslation.locale.name,
      "locale": categorytranslation.locale.index,
      "name": categorytranslation.name,
      "description": categorytranslation.description,
      "category_id": categorytranslation.categoryId,
    };
  }

  Future<CategoryTranslation> find(String id, {RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await findR(
        id,
        options: options.copyWithAdded(
          queryParameters: {},
        ),
      );
      return modelFromMap(response.data!["category_translation"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<void> delete(String id, {RequestOptions? options}) async {
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

  Future<CategoryTranslation> create(
      {required Languages locale,
      required String name,
      String? description,
      required String categoryId,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await createR(
        options: options.copyWithAdded(data: {
          if (locale != null) 'locale': locale.name,
          if (name != null) 'name': name,
          if (description != null) 'description': description,
          if (categoryId != null) 'category_id': categoryId,
        }),
      );
      return modelFromMap(response.data!["category_translation"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<CategoryTranslation> update(String id,
      {Languages? locale,
      String? name,
      String? description,
      String? categoryId,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await updateR(
        id,
        options: options.copyWithAdded(
          data: {
            if (locale != null) 'locale': locale.name,
            if (name != null) 'name': name,
            if (description != null) 'description': description,
            if (categoryId != null) 'category_id': categoryId
          },
        ),
      );
      return modelFromMap(response.data!["category_translation"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<PaginatedCategoryTranslation> list(
      {int? page = 1,
      int? limit = 24,
      CategoryTranslationSortables? sort,
      SortOrder? order,
      String? search,
      CategoryTranslationSearchables? searchIn,
      Map<CategoryTranslationFields, String>? where,
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
        // [where] is a map of [CategoryTranslationFields] and [String], it should convert to a map of [String] and [String].
        if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
      }));
      return PaginatedCategoryTranslation.fromMap(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }
}

// CategoryTranslationRelations
// no relations
// CategoryTranslationFilterables
enum CategoryTranslationFilterables {
  id,
  locale,
  name,
  description,
  categoryId
}

// CategoryTranslationSortables
enum CategoryTranslationSortables { id, locale, name, description, categoryId }

// CategoryTranslationSearchables
enum CategoryTranslationSearchables {
  id,
  locale,
  name,
  description,
  categoryId
}

// CategoryTranslationFields
enum CategoryTranslationFields { id, locale, name, description, categoryId }

// CategoryTranslationTranslatables
// no fields
// CategoryTranslationAuthCredentials
// no fields
// PaginatedCategoryTranslation
class PaginatedCategoryTranslation extends PaginatedModel {
  PaginatedCategoryTranslation({required this.data, required this.meta});

  final List<CategoryTranslation> data;

  final PaginationMeta meta;

  static PaginatedCategoryTranslation fromMap(Map<String, dynamic> map) {
    return PaginatedCategoryTranslation(
      data: List<CategoryTranslation>.from(
          map['data'].map((x) => CategoryTranslation.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }
}

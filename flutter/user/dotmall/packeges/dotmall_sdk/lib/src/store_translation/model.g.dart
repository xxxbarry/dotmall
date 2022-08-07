// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TableAnnotationGenerator
// **************************************************************************

// StoreTranslations
class StoreTranslations extends Collection<StoreTranslation> {
  StoreTranslations(this.manager);

  final Manager manager;

  final String table = "store_translations";

  final String scope = "store_translations";

  static StoreTranslation modelFromMap(Map<String, dynamic> map) {
    return StoreTranslation(
      id: map["id"],
      locale: Languages.values.firstWhere((e) => e.name == map["locale"]),
      name: map["name"],
      description: map["description"],
      storeId: map["store_id"],
    );
  }

  static Map<String, dynamic> modelToMap(StoreTranslation storetranslation) {
    return {
      "id": storetranslation.id,
      "locale": storetranslation.locale.name,
      "name": storetranslation.name,
      "description": storetranslation.description,
      "store_id": storetranslation.storeId,
    };
  }

  Future<StoreTranslation> find(String id, {RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await findR(
        id,
        options: options.copyWithAdded(
          queryParameters: {},
        ),
      );
      return modelFromMap(response.data!["store_translation"]);
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

  Future<StoreTranslation> create(
      {required Languages locale,
      required String name,
      String? description,
      required String storeId,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await createR(
        options: options.copyWithAdded(data: {
          if (locale != null) 'locale': locale.name,
          if (name != null) 'name': name,
          if (description != null) 'description': description,
          if (storeId != null) 'store_id': storeId,
        }),
      );
      return modelFromMap(response.data!["store_translation"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<StoreTranslation> update(String id,
      {Languages? locale,
      String? name,
      String? description,
      String? storeId,
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
            if (storeId != null) 'store_id': storeId
          },
        ),
      );
      return modelFromMap(response.data!["store_translation"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<PaginatedStoreTranslation> list(
      {int? page = 1,
      int? limit = 24,
      StoreTranslationSortables? sort,
      SortOrder? order,
      String? search,
      StoreTranslationSearchables? searchIn,
      Map<StoreTranslationFields, String>? where,
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
        // [where] is a map of [StoreTranslationFields] and [String], it should convert to a map of [String] and [String].
        if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
      }));
      return PaginatedStoreTranslation.fromMap(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }
}

// StoreTranslationRelations
// no relations
// StoreTranslationFilterables
enum StoreTranslationFilterables { id, locale, name, description, storeId }

// StoreTranslationSortables
enum StoreTranslationSortables { id, locale, name, description, storeId }

// StoreTranslationSearchables
enum StoreTranslationSearchables { id, locale, name, description, storeId }

// StoreTranslationFields
enum StoreTranslationFields { id, locale, name, description, storeId }

// StoreTranslationTranslatables
// no fields
// StoreTranslationAuthCredentials
// no fields
// PaginatedStoreTranslation
class PaginatedStoreTranslation extends PaginatedModel {
  PaginatedStoreTranslation({required this.data, required this.meta});

  final List<StoreTranslation> data;

  final PaginationMeta meta;

  static PaginatedStoreTranslation fromMap(Map<String, dynamic> map) {
    return PaginatedStoreTranslation(
      data: List<StoreTranslation>.from(
          map['data'].map((x) => StoreTranslation.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TableAnnotationGenerator
// **************************************************************************

// ProductTranslations
class ProductTranslations extends Collection<ProductTranslation> {
  ProductTranslations(this.manager);

  final Manager manager;

  final String table = "product_translations";

  final String scope = "product_translations";

  ProductTranslations copyWith({Manager? manager}) {
    return ProductTranslations(manager ?? this.manager);
  }

  ProductTranslations copyWithConfigs(Configs? configs) {
    return ProductTranslations(this.manager.copyWith(configs: configs));
  }

  static ProductTranslation modelFromMap(Map<String, dynamic> map) {
    return ProductTranslation(
      id: map["id"],
      locale: Languages.values.firstWhere((e) => e.name == map["locale"]),
      name: map["name"],
      description: map["description"],
      productId: map["product_id"],
    );
  }

  static Map<String, dynamic> modelToMap(
      ProductTranslation producttranslation) {
    return {
      "id": producttranslation.id,
      "locale": producttranslation.locale.name,
      "locale": producttranslation.locale.index,
      "name": producttranslation.name,
      "description": producttranslation.description,
      "product_id": producttranslation.productId,
    };
  }

  Future<ProductTranslation> find(String id, {RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await findR(
        id,
        options: options.copyWithAdded(
          queryParameters: {},
        ),
      );
      return modelFromMap(response.data!["product_translation"]);
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

  Future<ProductTranslation> create(
      {required Languages locale,
      required String name,
      String? description,
      required String productId,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await createR(
        options: options.copyWithAdded(data: {
          if (locale != null) 'locale': locale.name,
          if (name != null) 'name': name,
          if (description != null) 'description': description,
          if (productId != null) 'product_id': productId,
        }),
      );
      return modelFromMap(response.data!["product_translation"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<ProductTranslation> update(String id,
      {Languages? locale,
      String? name,
      String? description,
      String? productId,
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
            if (productId != null) 'product_id': productId
          },
        ),
      );
      return modelFromMap(response.data!["product_translation"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<PaginatedProductTranslation> list(
      {int? page = 1,
      int? limit = 24,
      ProductTranslationSortables? sort,
      SortOrder? order,
      String? search,
      ProductTranslationSearchables? searchIn,
      Map<ProductTranslationFields, String>? where,
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
        // [where] is a map of [ProductTranslationFields] and [String], it should convert to a map of [String] and [String].
        if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
      }));
      return PaginatedProductTranslation.fromMap(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }
}

// ProductTranslationRelations
// no relations
// ProductTranslationFilterables
enum ProductTranslationFilterables { id, locale, name, description, productId }

// ProductTranslationSortables
enum ProductTranslationSortables { id, locale, name, description, productId }

// ProductTranslationSearchables
enum ProductTranslationSearchables { id, locale, name, description, productId }

// ProductTranslationFields
enum ProductTranslationFields { id, locale, name, description, productId }

// ProductTranslationTranslatables
// no fields
// ProductTranslationAuthCredentials
// no fields
// PaginatedProductTranslation
class PaginatedProductTranslation extends PaginatedModel {
  PaginatedProductTranslation({required this.data, required this.meta});

  final List<ProductTranslation> data;

  final PaginationMeta meta;

  static PaginatedProductTranslation fromMap(Map<String, dynamic> map) {
    return PaginatedProductTranslation(
      data: List<ProductTranslation>.from(
          map['data'].map((x) => ProductTranslation.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }
}

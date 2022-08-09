// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TableAnnotationGenerator
// **************************************************************************

// Stores
class Stores extends Collection<Store> {
  Stores(this.manager);

  final Manager manager;

  final String table = "stores";

  final String scope = "stores";

  static Store modelFromMap(Map<String, dynamic> map) {
    return Store(
      id: map["id"],
      name: map["name"],
      description: map["description"],
      status: map["status"],
      merchantProfileId: map["merchant_profile_id"],
      createdAt: DateTime.tryParse(map["created_at"].toString()),
      updatedAt: DateTime.tryParse(map["updated_at"].toString()),
      validatedAt: DateTime.tryParse(map["validated_at"].toString()),
      deletedAt: DateTime.tryParse(map["deleted_at"].toString()),
      photos: [for (var item in map["photos"] ?? []) Files.modelFromMap(item)],
      translations: [
        for (var item in map["translations"] ?? [])
          StoreTranslations.modelFromMap(item)
      ],
    );
  }

  static Map<String, dynamic> modelToMap(Store store) {
    return {
      "id": store.id,
      "name": store.name,
      "description": store.description,
      "status": store.status,
      "merchant_profile_id": store.merchantProfileId,
      "created_at": store.createdAt,
      "updated_at": store.updatedAt,
      "validated_at": store.validatedAt,
      "deleted_at": store.deletedAt,
      "photos": [for (var item in store.photos ?? []) item.modelToMap()],
      "translations": [
        for (var item in store.translations ?? []) item.modelToMap()
      ],
    };
  }

  Future<Store> find(String id,
      {List<StoreRelations>? load, RequestOptions? options}) async {
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
      return modelFromMap(response.data!["store"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<void> delete(String id,
      {List<StoreRelations>? load, RequestOptions? options}) async {
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

  Future<Store> create(
      {required String name,
      String? description,
      required String merchantProfileId,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? validatedAt,
      DateTime? deletedAt,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await createR(
        options: options.copyWithAdded(data: {
          if (name != null) 'name': name,
          if (description != null) 'description': description,
          if (merchantProfileId != null)
            'merchant_profile_id': merchantProfileId,
          if (createdAt != null) 'created_at': createdAt,
          if (updatedAt != null) 'updated_at': updatedAt,
          if (validatedAt != null) 'validated_at': validatedAt,
          if (deletedAt != null) 'deleted_at': deletedAt,
        }),
      );
      return modelFromMap(response.data!["store"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<Store> update(String id,
      {String? name,
      String? description,
      int? status,
      String? merchantProfileId,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? validatedAt,
      DateTime? deletedAt,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await updateR(
        id,
        options: options.copyWithAdded(
          data: {
            if (name != null) 'name': name,
            if (description != null) 'description': description,
            if (status != null) 'status': status,
            if (merchantProfileId != null)
              'merchant_profile_id': merchantProfileId,
            if (createdAt != null) 'created_at': createdAt,
            if (updatedAt != null) 'updated_at': updatedAt,
            if (validatedAt != null) 'validated_at': validatedAt,
            if (deletedAt != null) 'deleted_at': deletedAt
          },
        ),
      );
      return modelFromMap(response.data!["store"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<PaginatedStore> list(
      {List<StoreRelations>? load,
      int? page = 1,
      int? limit = 24,
      StoreSortables? sort,
      SortOrder? order,
      String? search,
      StoreSearchables? searchIn,
      Map<StoreFields, String>? where,
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
        // [where] is a map of [StoreFields] and [String], it should convert to a map of [String] and [String].
        if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
        if (load != null) 'load': load.map((e) => e.name).toList()
      }));
      return PaginatedStore.fromMap(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }
}

// StoreRelations
enum StoreRelations { photos, translations }

// StoreFilterables
enum StoreFilterables {
  id,
  name,
  description,
  status,
  merchantProfileId,
  createdAt,
  updatedAt,
  validatedAt,
  deletedAt
}

// StoreSortables
enum StoreSortables {
  id,
  name,
  description,
  status,
  merchantProfileId,
  createdAt,
  updatedAt,
  validatedAt,
  deletedAt
}

// StoreSearchables
enum StoreSearchables {
  id,
  name,
  description,
  status,
  merchantProfileId,
  createdAt,
  updatedAt,
  validatedAt,
  deletedAt
}

// StoreFields
enum StoreFields {
  id,
  name,
  description,
  status,
  merchantProfileId,
  createdAt,
  updatedAt,
  validatedAt,
  deletedAt
}

// StoreTranslatables
// no fields
// StoreAuthCredentials
// no fields
// PaginatedStore
class PaginatedStore extends PaginatedModel {
  PaginatedStore({required this.data, required this.meta});

  final List<Store> data;

  final PaginationMeta meta;

  static PaginatedStore fromMap(Map<String, dynamic> map) {
    return PaginatedStore(
      data: List<Store>.from(map['data'].map((x) => Store.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TableAnnotationGenerator
// **************************************************************************

/// Addresses
class Addresses extends Collection<Address> {
  Addresses(this.manager);

  final Manager manager;

  final String table = "addresses";

  final String scope = "addresses";

  SemanticCardMetaData semanticsOf(Address model) {
    return SemanticCardMetaData<String?, String?, File?>(
      title: null,
      subtitle: null,
      image: null,
    );
  }

  @override
  PaginatedModel<Address> paginatedModelFromMap(Map<String, dynamic> map) {
    return PaginatedAddress.fromMap(map);
  }

  Addresses copyWith({Manager? manager}) {
    return Addresses(manager ?? this.manager);
  }

  Addresses copyWithConfigs(Configs? configs) {
    return Addresses(this.manager.copyWith(configs: configs));
  }

  static Address modelFromMap(Map<String, dynamic> map) {
    return Address(
      userId: map["user_id"],
      id: map["id"],
      primary: map["primary"],
      secondary: map["secondary"],
      city: map["city"],
      state: map["state"],
      zip: map["zip"],
      country: map["country"],
      latitude: double.tryParse(map["latitude"].toString()),
      longitude: double.tryParse(map["longitude"].toString()),
      createdAt: DateTime.tryParse(map["created_at"].toString()),
      updatedAt: DateTime.tryParse(map["updated_at"].toString()),
      validatedAt: DateTime.tryParse(map["validated_at"].toString()),
      deletedAt: DateTime.tryParse(map["deleted_at"].toString()),
    );
  }

  static Map<String, dynamic> modelToMap(Address address) {
    return {
      "user_id": address.userId,
      "id": address.id,
      "primary": address.primary,
      "secondary": address.secondary,
      "city": address.city,
      "state": address.state,
      "zip": address.zip,
      "country": address.country,
      "latitude": address.latitude,
      "longitude": address.longitude,
      "created_at": address.createdAt,
      "updated_at": address.updatedAt,
      "validated_at": address.validatedAt,
      "deleted_at": address.deletedAt,
    };
  }

  Future<Address> find(String id, {RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await findR(
        id,
        options: options.copyWithAdded(
          queryParameters: {},
        ),
      );
      return modelFromMap(response.data!["address"]);
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

  Future<Address> create(
      {required String userId,
      required String primary,
      String? secondary,
      String? city,
      String? state,
      String? zip,
      String? country,
      double? latitude,
      double? longitude,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? validatedAt,
      DateTime? deletedAt,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await createR(
        options: options.copyWithAdded(data: {
          if (userId != null) 'user_id': userId,
          if (primary != null) 'primary': primary,
          if (secondary != null) 'secondary': secondary,
          if (city != null) 'city': city,
          if (state != null) 'state': state,
          if (zip != null) 'zip': zip,
          if (country != null) 'country': country,
          if (latitude != null) 'latitude': latitude,
          if (longitude != null) 'longitude': longitude,
          if (createdAt != null) 'created_at': createdAt,
          if (updatedAt != null) 'updated_at': updatedAt,
          if (validatedAt != null) 'validated_at': validatedAt,
          if (deletedAt != null) 'deleted_at': deletedAt,
        }),
      );
      return modelFromMap(response.data!["address"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<Address> update(String id,
      {String? userId,
      String? primary,
      String? secondary,
      String? city,
      String? state,
      String? zip,
      String? country,
      double? latitude,
      double? longitude,
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
            if (userId != null) 'user_id': userId,
            if (primary != null) 'primary': primary,
            if (secondary != null) 'secondary': secondary,
            if (city != null) 'city': city,
            if (state != null) 'state': state,
            if (zip != null) 'zip': zip,
            if (country != null) 'country': country,
            if (latitude != null) 'latitude': latitude,
            if (longitude != null) 'longitude': longitude,
            if (createdAt != null) 'created_at': createdAt,
            if (updatedAt != null) 'updated_at': updatedAt,
            if (validatedAt != null) 'validated_at': validatedAt,
            if (deletedAt != null) 'deleted_at': deletedAt
          },
        ),
      );
      return modelFromMap(response.data!["address"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<PaginatedAddress> list(
      {int? page = 1,
      int? limit = 24,
      AddressSortables? sort,
      SortOrder? order,
      String? search,
      AddressSearchables? searchIn,
      Map<AddressFields, String>? where,
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
        // [where] is a map of [AddressFields] and [String], it should convert to a map of [String] and [String].
        if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
      }));
      return PaginatedAddress.fromMap(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }
}

/// AddressListOptions
class AddressListOptions extends RequestOptions {
  AddressListOptions(
      {int? page = 1,
      int? limit = 24,
      AddressSortables? sort,
      SortOrder? order,
      String? search,
      AddressSearchables? searchIn,
      Map<AddressFields, String>? where,
      Map<String, dynamic>? queryParameters,
      super.cancelToken,
      super.data,
      super.onReceiveProgress,
      super.onSendProgress,
      super.options})
      : super(queryParameters: {
          ...?queryParameters,
          if (page != null) 'page': page.toString(),
          if (limit != null) 'limit': limit.toString(),
          if (sort != null) 'sort': sort.name,
          if (order != null) 'order': order.name,
          if (search != null) 'search': search,
          if (searchIn != null) 'searchIn': searchIn.name,
          // [where] is a map of [AddressFields] and [String], it should convert to a map of [String] and [String].
          if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
        });
}

/// AddressFindOptions
class AddressFindOptions extends RequestOptions {
  AddressFindOptions(
      {Map<String, dynamic>? queryParameters,
      super.cancelToken,
      super.data,
      super.onReceiveProgress,
      super.onSendProgress,
      super.options})
      : super(queryParameters: {
          ...?queryParameters,
        });
}

/// AddressRelations
// no relations
/// AddressFilterables
enum AddressFilterables {
  userId,
  id,
  primary,
  secondary,
  city,
  state,
  zip,
  country,
  latitude,
  longitude,
  createdAt,
  updatedAt,
  validatedAt,
  deletedAt
}

/// AddressSortables
enum AddressSortables {
  userId,
  id,
  primary,
  secondary,
  city,
  state,
  zip,
  country,
  latitude,
  longitude,
  createdAt,
  updatedAt,
  validatedAt,
  deletedAt
}

/// AddressSearchables
enum AddressSearchables {
  userId,
  id,
  primary,
  secondary,
  city,
  state,
  zip,
  country,
  latitude,
  longitude,
  createdAt,
  updatedAt,
  validatedAt,
  deletedAt
}

/// AddressFields
enum AddressFields {
  userId,
  id,
  primary,
  secondary,
  city,
  state,
  zip,
  country,
  latitude,
  longitude,
  createdAt,
  updatedAt,
  validatedAt,
  deletedAt
}

/// AddressTranslatables
// no fields
/// AddressAuthCredentials
// no fields
/// PaginatedAddress
class PaginatedAddress extends PaginatedModel<Address> {
  PaginatedAddress({required this.data, required this.meta});

  final List<Address> data;

  final PaginationMeta meta;

  static PaginatedAddress fromMap(Map<String, dynamic> map) {
    return PaginatedAddress(
      data: List<Address>.from(map['data'].map((x) => Address.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }
}

/// AddressExtentions
extension AddressExtensions on Address {}

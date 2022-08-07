// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TableAnnotationGenerator
// **************************************************************************

// CustomerProfiles
class CustomerProfiles extends Collection<CustomerProfile> {
  CustomerProfiles(this.manager);

  final Manager manager;

  final String table = "customer_profiles";

  final String scope = "customer_profiles";

  static CustomerProfile modelFromMap(Map<String, dynamic> map) {
    return CustomerProfile(
      id: map["id"],
      accountId: map["account_id"],
      deletedAt: DateTime.tryParse(map["deleted_at"] ?? ""),
      validatedAt: DateTime.tryParse(map["validated_at"] ?? ""),
    );
  }

  static Map<String, dynamic> modelToMap(CustomerProfile customerprofile) {
    return {
      "id": customerprofile.id,
      "account_id": customerprofile.accountId,
      "deleted_at": customerprofile.deletedAt,
      "validated_at": customerprofile.validatedAt,
    };
  }

  Future<CustomerProfile> find(String id, {RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await findR(
        id,
        options: options.copyWithAdded(
          queryParameters: {},
        ),
      );
      return modelFromMap(response.data!["customer_profile"]);
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

  Future<CustomerProfile> create(
      {required String accountId,
      DateTime? deletedAt,
      DateTime? validatedAt,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await createR(
        options: options.copyWithAdded(data: {
          if (accountId != null) 'account_id': accountId,
          if (deletedAt != null) 'deleted_at': deletedAt,
          if (validatedAt != null) 'validated_at': validatedAt,
        }),
      );
      return modelFromMap(response.data!["customer_profile"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<CustomerProfile> update(String id,
      {String? accountId,
      DateTime? deletedAt,
      DateTime? validatedAt,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await updateR(
        id,
        options: options.copyWithAdded(
          data: {
            if (accountId != null) 'account_id': accountId,
            if (deletedAt != null) 'deleted_at': deletedAt,
            if (validatedAt != null) 'validated_at': validatedAt
          },
        ),
      );
      return modelFromMap(response.data!["customer_profile"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<PaginatedCustomerProfile> list(
      {int? page = 1,
      int? limit = 24,
      CustomerProfileSortables? sort,
      SortOrder? order,
      String? search,
      CustomerProfileSearchables? searchIn,
      Map<CustomerProfileFields, String>? where,
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
        // [where] is a map of [CustomerProfileFields] and [String], it should convert to a map of [String] and [String].
        if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
      }));
      return PaginatedCustomerProfile.fromMap(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }
}

// CustomerProfileRelations
// no relations
// CustomerProfileFilterables
enum CustomerProfileFilterables { id, accountId, deletedAt, validatedAt }

// CustomerProfileSortables
enum CustomerProfileSortables { id, accountId, deletedAt, validatedAt }

// CustomerProfileSearchables
enum CustomerProfileSearchables { id, accountId, deletedAt, validatedAt }

// CustomerProfileFields
enum CustomerProfileFields { id, accountId, deletedAt, validatedAt }

// CustomerProfileTranslatables
// no fields
// CustomerProfileAuthCredentials
// no fields
// PaginatedCustomerProfile
class PaginatedCustomerProfile extends PaginatedModel {
  PaginatedCustomerProfile({required this.data, required this.meta});

  final List<CustomerProfile> data;

  final PaginationMeta meta;

  static PaginatedCustomerProfile fromMap(Map<String, dynamic> map) {
    return PaginatedCustomerProfile(
      data: List<CustomerProfile>.from(
          map['data'].map((x) => CustomerProfile.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }
}

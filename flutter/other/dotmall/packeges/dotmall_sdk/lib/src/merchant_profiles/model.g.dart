// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TableAnnotationGenerator
// **************************************************************************

/// MerchantProfiles
class MerchantProfiles extends Collection<MerchantProfile> {
  MerchantProfiles(this.manager);

  final Manager manager;

  final String table = "merchant_profiles";

  final String scope = "merchant_profiles";

  SemanticCardMetaData semanticsOf(MerchantProfile model) {
    return SemanticCardMetaData<String?, String?, File?>(
      title: null,
      subtitle: null,
      image: null,
    );
  }

  @override
  PaginatedModel<MerchantProfile> paginatedModelFromMap(
      Map<String, dynamic> map) {
    return PaginatedMerchantProfile.fromMap(map);
  }

  MerchantProfiles copyWith({Manager? manager}) {
    return MerchantProfiles(manager ?? this.manager);
  }

  MerchantProfiles copyWithConfigs(Configs? configs) {
    return MerchantProfiles(this.manager.copyWith(configs: configs));
  }

  static MerchantProfile modelFromMap(Map<String, dynamic> map) {
    return MerchantProfile(
      id: map["id"],
      accountId: map["account_id"],
      deletedAt: DateTime.tryParse(map["deleted_at"].toString()),
      validatedAt: DateTime.tryParse(map["validated_at"].toString()),
    );
  }

  static Map<String, dynamic> modelToMap(MerchantProfile merchantprofile) {
    return {
      "id": merchantprofile.id,
      "account_id": merchantprofile.accountId,
      "deleted_at": merchantprofile.deletedAt,
      "validated_at": merchantprofile.validatedAt,
    };
  }

  Future<MerchantProfile> find(String id, {RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await findR(
        id,
        options: options.copyWithAdded(
          queryParameters: {},
        ),
      );
      return modelFromMap(response.data!["merchant_profile"]);
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

  Future<MerchantProfile> create(
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
      return modelFromMap(response.data!["merchant_profile"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<MerchantProfile> update(String id,
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
      return modelFromMap(response.data!["merchant_profile"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<PaginatedMerchantProfile> list(
      {int? page = 1,
      int? limit = 24,
      MerchantProfileSortables? sort,
      SortOrder? order,
      String? search,
      MerchantProfileSearchables? searchIn,
      Map<MerchantProfileFields, String>? where,
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
        // [where] is a map of [MerchantProfileFields] and [String], it should convert to a map of [String] and [String].
        if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
      }));
      return PaginatedMerchantProfile.fromMap(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }
}

/// MerchantProfileListOptions
class MerchantProfileListOptions extends RequestOptions {
  MerchantProfileListOptions(
      {int? page = 1,
      int? limit = 24,
      MerchantProfileSortables? sort,
      SortOrder? order,
      String? search,
      MerchantProfileSearchables? searchIn,
      Map<MerchantProfileFields, String>? where,
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
          // [where] is a map of [MerchantProfileFields] and [String], it should convert to a map of [String] and [String].
          if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
        });
}

/// MerchantProfileFindOptions
class MerchantProfileFindOptions extends RequestOptions {
  MerchantProfileFindOptions(
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

/// MerchantProfileRelations
// no relations
/// MerchantProfileFilterables
enum MerchantProfileFilterables { id, accountId, deletedAt, validatedAt }

/// MerchantProfileSortables
enum MerchantProfileSortables { id, accountId, deletedAt, validatedAt }

/// MerchantProfileSearchables
enum MerchantProfileSearchables { id, accountId, deletedAt, validatedAt }

/// MerchantProfileFields
enum MerchantProfileFields { id, accountId, deletedAt, validatedAt }

/// MerchantProfileTranslatables
// no fields
/// MerchantProfileAuthCredentials
// no fields
/// PaginatedMerchantProfile
class PaginatedMerchantProfile extends PaginatedModel<MerchantProfile> {
  PaginatedMerchantProfile({required this.data, required this.meta});

  final List<MerchantProfile> data;

  final PaginationMeta meta;

  static PaginatedMerchantProfile fromMap(Map<String, dynamic> map) {
    return PaginatedMerchantProfile(
      data: List<MerchantProfile>.from(
          map['data'].map((x) => MerchantProfile.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }
}

/// MerchantProfileExtentions
extension MerchantProfileExtensions on MerchantProfile {}

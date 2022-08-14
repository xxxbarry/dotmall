// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TableAnnotationGenerator
// **************************************************************************

/// Accounts
class Accounts extends Collection<Account> {
  Accounts(this.manager);

  final Manager manager;

  final String table = "accounts";

  final String scope = "accounts";

  SemanticCardMetaData semanticsOf(Account model) {
    return SemanticCardMetaData<String?, String?, File?>(
      title: null,
      subtitle: null,
      image: null,
    );
  }

  @override
  PaginatedModel<Account> paginatedModelFromMap(Map<String, dynamic> map) {
    return PaginatedAccount.fromMap(map);
  }

  Accounts copyWith({Manager? manager}) {
    return Accounts(manager ?? this.manager);
  }

  Accounts copyWithConfigs(Configs? configs) {
    return Accounts(this.manager.copyWith(configs: configs));
  }

  static Account modelFromMap(Map<String, dynamic> map) {
    return Account(
      id: map["id"],
      name: map["name"],
      description: map["description"],
      userId: map["user_id"],
      type: AccountType.values[map["type"]],
      data: map["data"],
      createdAt: DateTime.tryParse(map["created_at"].toString()),
      updatedAt: DateTime.tryParse(map["updated_at"].toString()),
      validatedAt: DateTime.tryParse(map["validated_at"].toString()),
      deletedAt: DateTime.tryParse(map["deleted_at"].toString()),
      photos: [for (var item in map["photos"] ?? []) Files.modelFromMap(item)],
    );
  }

  static Map<String, dynamic> modelToMap(Account account) {
    return {
      "id": account.id,
      "name": account.name,
      "description": account.description,
      "user_id": account.userId,
      "type": account.type.index,
      "data": account.data,
      "created_at": account.createdAt,
      "updated_at": account.updatedAt,
      "validated_at": account.validatedAt,
      "deleted_at": account.deletedAt,
      "photos": [for (var item in account.photos ?? []) item.toMap()],
    };
  }

  Future<Account> find(String id,
      {List<AccountRelations>? load, RequestOptions? options}) async {
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
      return modelFromMap(response.data!["account"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<void> delete(String id,
      {List<AccountRelations>? load, RequestOptions? options}) async {
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

  Future<Account> create(
      {required String name,
      String? description,
      required String userId,
      required AccountType type,
      Map<String, dynamic>? data,
      DateTime? validatedAt,
      DateTime? deletedAt,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await createR(
        options: options.copyWithAdded(data: {
          if (name != null) 'name': name,
          if (description != null) 'description': description,
          if (userId != null) 'user_id': userId,
          if (type != null) 'type': type.index,
          if (data != null) 'data': data,
          if (validatedAt != null) 'validated_at': validatedAt,
          if (deletedAt != null) 'deleted_at': deletedAt,
        }),
      );
      return modelFromMap(response.data!["account"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<Account> update(String id,
      {String? name,
      String? description,
      String? userId,
      AccountType? type,
      Map<String, dynamic>? data,
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
            if (userId != null) 'user_id': userId,
            if (type != null) 'type': type.index,
            if (data != null) 'data': data,
            if (createdAt != null) 'created_at': createdAt,
            if (updatedAt != null) 'updated_at': updatedAt,
            if (validatedAt != null) 'validated_at': validatedAt,
            if (deletedAt != null) 'deleted_at': deletedAt
          },
        ),
      );
      return modelFromMap(response.data!["account"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<PaginatedAccount> list(
      {List<AccountRelations>? load,
      int? page = 1,
      int? limit = 24,
      AccountSortables? sort,
      SortOrder? order,
      String? search,
      AccountSearchables? searchIn,
      Map<AccountFields, String>? where,
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
        // [where] is a map of [AccountFields] and [String], it should convert to a map of [String] and [String].
        if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
        if (load != null) 'load': load.map((e) => e.name).toList()
      }));
      return PaginatedAccount.fromMap(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }
}

/// AccountListOptions
class AccountListOptions extends RequestOptions {
  AccountListOptions(
      {List<AccountRelations>? load,
      int? page = 1,
      int? limit = 24,
      AccountSortables? sort,
      SortOrder? order,
      String? search,
      AccountSearchables? searchIn,
      Map<AccountFields, String>? where,
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
          // [where] is a map of [AccountFields] and [String], it should convert to a map of [String] and [String].
          if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
          if (load != null) 'load': load.map((e) => e.name).toList()
        });
}

/// AccountFindOptions
class AccountFindOptions extends RequestOptions {
  AccountFindOptions(
      {List<AccountRelations>? load,
      Map<String, dynamic>? queryParameters,
      super.cancelToken,
      super.data,
      super.onReceiveProgress,
      super.onSendProgress,
      super.options})
      : super(queryParameters: {
          ...?queryParameters,
          if (load != null) 'load': load.map((e) => e.name).toList()
        });
}

/// AccountRelations
enum AccountRelations { photos }

/// AccountFilterables
enum AccountFilterables {
  id,
  name,
  description,
  userId,
  type,
  data,
  createdAt,
  updatedAt,
  validatedAt,
  deletedAt
}

/// AccountSortables
enum AccountSortables {
  id,
  name,
  description,
  userId,
  type,
  data,
  createdAt,
  updatedAt,
  validatedAt,
  deletedAt
}

/// AccountSearchables
enum AccountSearchables {
  id,
  name,
  description,
  userId,
  type,
  data,
  createdAt,
  updatedAt,
  validatedAt,
  deletedAt
}

/// AccountFields
enum AccountFields {
  id,
  name,
  description,
  userId,
  type,
  data,
  createdAt,
  updatedAt,
  validatedAt,
  deletedAt
}

/// AccountTranslatables
// no fields
/// AccountAuthCredentials
// no fields
/// PaginatedAccount
class PaginatedAccount extends PaginatedModel<Account> {
  PaginatedAccount({required this.data, required this.meta});

  final List<Account> data;

  final PaginationMeta meta;

  static PaginatedAccount fromMap(Map<String, dynamic> map) {
    return PaginatedAccount(
      data: List<Account>.from(map['data'].map((x) => Account.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }
}

/// AccountExtentions
extension AccountExtensions on Account {}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TableAnnotationGenerator
// **************************************************************************

/// Users
class Users extends AuthCollection<User, UserAuthCredentials> {
  Users(this.manager);

  final Manager manager;

  final String table = "users";

  final String scope = "users";

  @override
  SemanticCardMetaData semanticsOf(Model model) {
    return SemanticCardMetaData(
      title: "null",
      subtitle: "null",
      image: "null",
    );
  }

  @override
  PaginatedModel<User> paginatedModelFromMap(Map<String, dynamic> map) {
    return PaginatedUser.fromMap(map);
  }

  Users copyWith({Manager? manager}) {
    return Users(manager ?? this.manager);
  }

  Users copyWithConfigs(Configs? configs) {
    return Users(this.manager.copyWith(configs: configs));
  }

  Future<AuthResponse<User>> signin(UserAuthCredentials credentials,
      {RequestOptions? options}) async {
    options = options ?? RequestOptions();
    var response = await signinR(
      options: options.copyWithAdded(data: credentials.toMap()),
    );

    return AuthResponse<User>(
      model: modelFromMap(response.data!["user"]),
      token: Token.fromMap(response.data!["token"]),
    );
  }

  Future<User> auth({RequestOptions? options}) async {
    options = options ?? RequestOptions();
    var response = await authR(options: options);

    return modelFromMap(response.data!["user"]);
  }

  Future<void> signout({RequestOptions? options}) async {
    options = options ?? RequestOptions();
    await signoutR(
      options: options,
    );
  }

  Future<AuthResponse<User>> signup(
      {required UserAuthCredentials credentials,
      RequestOptions? options}) async {
    options = options ?? RequestOptions();
    var response = await signupR(
      options: options.copyWithAdded(data: {
        ...?options.data,
        ...credentials.toMap(),
      }),
    );
    return AuthResponse<User>(
      model: modelFromMap(response.data!["user"]),
      token: Token.fromMap(response.data!["token"]),
    );
  }

  static User modelFromMap(Map<String, dynamic> map) {
    return User(
      id: map["id"],
      password: map["password"],
      createdAt: DateTime.tryParse(map["created_at"].toString()),
      updatedAt: DateTime.tryParse(map["updated_at"].toString()),
      accounts: [
        for (var item in map["accounts"] ?? []) Accounts.modelFromMap(item)
      ],
      emails: [for (var item in map["emails"] ?? []) Emails.modelFromMap(item)],
      phones: [for (var item in map["phones"] ?? []) Phones.modelFromMap(item)],
    );
  }

  static Map<String, dynamic> modelToMap(User user) {
    return {
      "id": user.id,
      "password": user.password,
      "created_at": user.createdAt,
      "updated_at": user.updatedAt,
      "accounts": [for (var item in user.accounts ?? []) item.toMap()],
      "emails": [for (var item in user.emails ?? []) item.toMap()],
      "phones": [for (var item in user.phones ?? []) item.toMap()],
    };
  }

  Future<User> find(String id,
      {List<UserRelations>? load, RequestOptions? options}) async {
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
      return modelFromMap(response.data!["user"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<void> delete(String id,
      {List<UserRelations>? load, RequestOptions? options}) async {
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

  Future<User> create(
      {required String? password, RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await createR(
        options: options.copyWithAdded(data: {
          if (password != null) 'password': password,
        }),
      );
      return modelFromMap(response.data!["user"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<User> update(String id,
      {String? password,
      DateTime? createdAt,
      DateTime? updatedAt,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await updateR(
        id,
        options: options.copyWithAdded(
          data: {
            if (password != null) 'password': password,
            if (createdAt != null) 'created_at': createdAt,
            if (updatedAt != null) 'updated_at': updatedAt
          },
        ),
      );
      return modelFromMap(response.data!["user"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<PaginatedUser> list(
      {List<UserRelations>? load,
      int? page = 1,
      int? limit = 24,
      UserSortables? sort,
      SortOrder? order,
      String? search,
      UserSearchables? searchIn,
      Map<UserFields, String>? where,
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
        // [where] is a map of [UserFields] and [String], it should convert to a map of [String] and [String].
        if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
        if (load != null) 'load': load.map((e) => e.name).toList()
      }));
      return PaginatedUser.fromMap(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }
}

/// UserListOptions
class UserListOptions extends RequestOptions {
  UserListOptions(
      {List<UserRelations>? load,
      int? page = 1,
      int? limit = 24,
      UserSortables? sort,
      SortOrder? order,
      String? search,
      UserSearchables? searchIn,
      Map<UserFields, String>? where,
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
          // [where] is a map of [UserFields] and [String], it should convert to a map of [String] and [String].
          if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
          if (load != null) 'load': load.map((e) => e.name).toList()
        });
}

/// UserFindOptions
class UserFindOptions extends RequestOptions {
  UserFindOptions(
      {List<UserRelations>? load,
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

/// UserRelations
enum UserRelations { accounts, emails, phones }

/// UserFilterables
enum UserFilterables { id, password, createdAt, updatedAt }

/// UserSortables
enum UserSortables { id, password, createdAt, updatedAt }

/// UserSearchables
enum UserSearchables { id, password, createdAt, updatedAt }

/// UserFields
enum UserFields { id, password, createdAt, updatedAt }

/// UserTranslatables
// no fields
/// UserAuthCredentials
class UserAuthCredentials extends AuthCredentials<String, String> {
  const UserAuthCredentials({required super.username, required super.password});
}

/// PaginatedUser
class PaginatedUser extends PaginatedModel<User> {
  PaginatedUser({required this.data, required this.meta});

  final List<User> data;

  final PaginationMeta meta;

  static PaginatedUser fromMap(Map<String, dynamic> map) {
    return PaginatedUser(
      data: List<User>.from(map['data'].map((x) => User.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }
}

/// UserExtentions
extension UserExtensions on User {}

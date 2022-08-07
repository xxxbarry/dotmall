import 'dart:convert';
import 'package:auto_sdk_annotations/auto_sdk_annotations.dart';
import 'package:dio/dio.dart';
import 'package:recase/recase.dart';

/// [Manager] is a class that provides access to the DotMall API.
/// It is a singleton class.
/// It is used to make requests to the DotMall API.
/// accept [Configs] to set the configs of the [Manager].
class Manager {
  // Auth<User>? auth = Auth<User>();

  final Configs configs;
  final Dio _client = Dio();
  Dio get client => _client;

  Token? _token;

  Token? get token => _token;

  set token(Token? token) {
    _token = token;
    _client.options.headers["Authorization"] = "Bearer ${token?.token}";
  }

  Manager(
    this.configs,
  ) {
    client.options.baseUrl = configs.endpoint;
    if (configs.language?.name != null) {
      client.options.headers['Accept-Language'] = configs.language?.name;
    }
    client.options.connectTimeout = 20000;
    client.options.receiveTimeout = 20000;
    client.options.headers = {
      ...client.options.headers,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Manager copyWith({
    Configs? configs,
  }) {
    return Manager(
      configs ?? this.configs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'configs': configs.toMap(),
    };
  }

  factory Manager.fromMap(Map<String, dynamic> map) {
    return Manager(
      Configs.fromMap(map['configs']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Manager.fromJson(String source) =>
      Manager.fromMap(json.decode(source));

  @override
  String toString() => 'Manager(configs: $configs)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Manager && other.configs == configs;
  }

  @override
  int get hashCode => configs.hashCode;
}

/// ValidationException
class ValidationException implements Exception {
  final String? message;
  final List<ValidationError> errors;
  ValidationException({
    this.message,
    required this.errors,
  });

  ValidationException copyWith({
    String? message,
    List<ValidationError>? errors,
  }) {
    return ValidationException(
      message: message ?? this.message,
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'errors': errors.map((x) => x.toMap()).toList(),
    };
  }

  factory ValidationException.fromMap(Map<String, dynamic> map) {
    return ValidationException(
      message: map['message'] != null ? map['message'] : null,
      errors: List<ValidationError>.from(
          map['errors'].map((x) => ValidationError.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ValidationException.fromJson(String source) =>
      ValidationException.fromMap(json.decode(source));

  @override
  String toString() =>
      'ValidationException(message: $message, errors: $errors)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValidationException && other.message == message;
  }

  @override
  int get hashCode => message.hashCode ^ errors.hashCode;
}

/// ValidationError
class ValidationError {
  final String rule;
  final String field;
  final String? message;
  final Map<String, dynamic>? args;
  ValidationError({
    required this.rule,
    required this.field,
    this.message,
    this.args,
  });

  ValidationError copyWith({
    String? rule,
    String? field,
    String? message,
    Map<String, dynamic>? args,
  }) {
    return ValidationError(
      rule: rule ?? this.rule,
      field: field ?? this.field,
      message: message ?? this.message,
      args: args ?? this.args,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rule': rule,
      'field': field,
      'message': message,
      'args': args,
    };
  }

  factory ValidationError.fromMap(Map<String, dynamic> map) {
    return ValidationError(
      rule: map['rule'],
      field: map['field'],
      message: map['message'] != null ? map['message'] : null,
      args: map['args'] != null ? Map<String, dynamic>.from(map['args']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ValidationError.fromJson(String source) =>
      ValidationError.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ValidationError(rule: $rule, field: $field, message: $message, args: $args)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValidationError &&
        other.rule == rule &&
        other.field == field &&
        other.message == message;
  }

  @override
  int get hashCode {
    return rule.hashCode ^ field.hashCode ^ message.hashCode ^ args.hashCode;
  }
}

/// Configs is a class that provides configuration for the DotMallSDK.
class Configs {
  String get endpoint =>
      mode == RunMode.production ? prodEndpoint : devEndpoint;
  final String prodEndpoint;
  final String devEndpoint;
  final RunMode mode;
  final Languages? language;
  final AuthCollection Function(Manager)? auth;
  Configs({
    this.prodEndpoint = "http://127.0.0.1:3333/api/v1/",
    this.devEndpoint = "http://127.0.0.1:3333/api/v1/",
    this.mode = RunMode.development,
    this.language,
    this.auth,
  });

  Configs copyWith({
    String? prodEndpoint,
    String? devEndpoint,
    RunMode? mode,
    Languages? language,
  }) {
    return Configs(
      prodEndpoint: prodEndpoint ?? this.prodEndpoint,
      devEndpoint: devEndpoint ?? this.devEndpoint,
      mode: mode ?? this.mode,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'prodEndpoint': prodEndpoint,
      'devEndpoint': devEndpoint,
      'mode': mode.name,
      'language': language?.name,
    };
  }

  factory Configs.fromMap(Map<String, dynamic> map) {
    return Configs(
      prodEndpoint: map['prodEndpoint'],
      devEndpoint: map['devEndpoint'],
      mode: RunMode.values[map['mode']],
      language: Languages.values[map['language']],
    );
  }

  String toJson() => json.encode(toMap());

  factory Configs.fromJson(String source) =>
      Configs.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Configs(prodEndpoint: $prodEndpoint, devEndpoint: $devEndpoint, mode: $mode, language: $language)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Configs &&
        other.prodEndpoint == prodEndpoint &&
        other.devEndpoint == devEndpoint &&
        other.mode == mode &&
        other.language == language;
  }

  @override
  int get hashCode {
    return prodEndpoint.hashCode ^
        devEndpoint.hashCode ^
        mode.hashCode ^
        language.hashCode;
  }
}

/// RequestLanguage enum
enum Languages {
  ar,
  en,
  fr,
}

/// RunMode is a class that provides the mode of the DotMallSDK.
enum RunMode {
  development,
  production,
}

/// [Model]
class Model {
  Model();
  //fromJson
  factory Model.fromJson(Map<String, dynamic> json) => Model();
  // toMap
  Map<String, dynamic> toMap() => <String, dynamic>{};
  factory Model.fromMap(Map<String, dynamic> map) => Model();
}

/// [ModelTranslation]
class ModelTranslation extends Model {
  @Column()
  final Languages locale;

  ModelTranslation({required this.locale});
}

/// [TimestampMixin] is a mixin that provides timestamp for the [Model].
mixin TimestampMixin {
  DateTime? createdAt;
  DateTime? updatedAt;
}

/// [deleted_at] is a mixin that provides deleted_at for the [Model].
mixin DeletedAtMixin {
  DateTime? deletedAt;
}

/// [ValidatedAtMixin] is a mixin that provides validated_at for the [Model].
mixin ValidatedAtMixin {
  DateTime? validatedAt;
}

/// [RelatedMixin] is a mixin that provides related_id & related_type for the [Model].
mixin RelatedMixin {
  String? relatedId;
  String? relatedType;
}

/// [Collection] all collections should extend this class.
abstract class Collection<T extends Model> {
  /// [manager] is the api Manager.
  Manager get manager;

  /// [scope] is the scope of the collection.
  String get scope;

  /// [init] is used to initialize the collection.
  void init() {}

  /// [findR]
  Future<Response<Map<String, dynamic>>> findR(String id,
      {RequestOptions? options}) async {
    try {
      return await manager.client.get<Map<String, dynamic>>(
        '$scope/$id',
        onReceiveProgress: options?.onReceiveProgress,
        queryParameters: options?.queryParameters,
        cancelToken: options?.cancelToken,
        options: options?.options,
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  /// [listR]
  Future<Response<Map<String, dynamic>>> listR(
      {RequestOptions? options}) async {
    try {
      return await manager.client.get(
        scope,
        onReceiveProgress: options?.onReceiveProgress,
        queryParameters: options?.queryParameters,
        cancelToken: options?.cancelToken,
        options: options?.options,
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  /// [createR]
  Future<Response<Map<String, dynamic>>> createR(
      {RequestOptions? options}) async {
    try {
      return await manager.client.post<Map<String, dynamic>>(
        scope,
        data: options?.data,
        onReceiveProgress: options?.onReceiveProgress,
        cancelToken: options?.cancelToken,
        options: options?.options,
        onSendProgress: options?.onSendProgress,
        queryParameters: options?.queryParameters,
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  /// [updateR]
  Future<Response<Map<String, dynamic>>> updateR(String id,
      {RequestOptions? options}) async {
    try {
      return await manager.client.put(
        '$scope/$id',
        data: options?.data,
        onReceiveProgress: options?.onReceiveProgress,
        cancelToken: options?.cancelToken,
        options: options?.options,
        onSendProgress: options?.onSendProgress,
        queryParameters: options?.queryParameters,
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  /// [deleteR]
  Future<Response> deleteR(String id, {RequestOptions? options}) async {
    try {
      return await manager.client.delete(
        '$scope/$id',
        cancelToken: options?.cancelToken,
        options: options?.options,
        data: options?.data,
        queryParameters: options?.queryParameters,
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  // /// [modelFromMap]
  // T fromMap(Map<String, dynamic> map);

  // /// [modelToMap]
  // Map<String, dynamic> toMap(T model);
}

/// [RequestOptions] is used to pass options to the request.
class RequestOptions {
  final void Function(int, int)? onSendProgress;
  final void Function(int, int)? onReceiveProgress;
  final CancelToken? cancelToken;
  final Options? options;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? data;
  RequestOptions({
    this.onSendProgress,
    this.onReceiveProgress,
    this.cancelToken,
    this.options,
    this.data,
    this.queryParameters,
  });

  RequestOptions copyWith({
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    CancelToken? cancelToken,
    Options? options,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) {
    return RequestOptions(
      onSendProgress: onSendProgress ?? this.onSendProgress,
      onReceiveProgress: onReceiveProgress ?? this.onReceiveProgress,
      cancelToken: cancelToken ?? this.cancelToken,
      options: options ?? this.options,
      data: data ?? this.data,
      queryParameters: queryParameters ?? this.queryParameters,
    );
  }

  RequestOptions copyWithAdded({Map? data, Map? queryParameters}) {
    return copyWith(data: {
      ...?this.data,
      ...?data,
    }, queryParameters: {
      ...?this.queryParameters,
      ...?queryParameters,
    });
  }
}

/// [PaginatedModel]
abstract class PaginatedModel {
  PaginationMeta get meta;
  List<Model> get data;
}

class PaginationMeta {
  final int total;
  final int pePage;
  final int currentPage;
  final int lastPage;
  final int firstPage;
  final String firstPageUrl;
  final String lastPageUrl;
  final String? nextPageUrl;
  final String? previousPageUrl;
  PaginationMeta({
    required this.total,
    required this.pePage,
    required this.currentPage,
    required this.lastPage,
    required this.firstPage,
    required this.firstPageUrl,
    required this.lastPageUrl,
    this.nextPageUrl,
    this.previousPageUrl,
  });

  PaginationMeta copyWith({
    int? total,
    int? pePage,
    int? currentPage,
    int? lastPage,
    int? firstPage,
    String? firstPageUrl,
    String? lastPageUrl,
    String? nextPageUrl,
    String? previousPageUrl,
  }) {
    return PaginationMeta(
      total: total ?? this.total,
      pePage: pePage ?? this.pePage,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      firstPage: firstPage ?? this.firstPage,
      firstPageUrl: firstPageUrl ?? this.firstPageUrl,
      lastPageUrl: lastPageUrl ?? this.lastPageUrl,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      previousPageUrl: previousPageUrl ?? this.previousPageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total'.snakeCase: total,
      'pePage'.snakeCase: pePage,
      'currentPage'.snakeCase: currentPage,
      'lastPage'.snakeCase: lastPage,
      'firstPage'.snakeCase: firstPage,
      'firstPageUrl'.snakeCase: firstPageUrl,
      'lastPageUrl'.snakeCase: lastPageUrl,
      'nextPageUrl'.snakeCase: nextPageUrl,
      'previousPageUrl'.snakeCase: previousPageUrl,
    };
  }

  factory PaginationMeta.fromMap(Map<String, dynamic> map) {
    return PaginationMeta(
      total: map['total'.snakeCase]?.toInt(),
      pePage: map['perPage'.snakeCase]?.toInt(),
      currentPage: map['currentPage'.snakeCase]?.toInt(),
      lastPage: map['lastPage'.snakeCase]?.toInt(),
      firstPage: map['firstPage'.snakeCase]?.toInt(),
      firstPageUrl: map['firstPageUrl'.snakeCase],
      lastPageUrl: map['lastPageUrl'.snakeCase],
      nextPageUrl: map['nextPageUrl'.snakeCase],
      previousPageUrl: map['previousPageUrl'.snakeCase],
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginationMeta.fromJson(String source) =>
      PaginationMeta.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Paginated(total: $total, pePage: $pePage, currentPage: $currentPage, lastPage: $lastPage, firstPage: $firstPage, firstPageUrl: $firstPageUrl, lastPageUrl: $lastPageUrl, nextPageUrl: $nextPageUrl, previousPageUrl: $previousPageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaginationMeta &&
        other.total == total &&
        other.pePage == pePage &&
        other.currentPage == currentPage &&
        other.lastPage == lastPage &&
        other.firstPage == firstPage &&
        other.firstPageUrl == firstPageUrl &&
        other.lastPageUrl == lastPageUrl &&
        other.nextPageUrl == nextPageUrl &&
        other.previousPageUrl == previousPageUrl;
  }

  @override
  int get hashCode {
    return total.hashCode ^
        pePage.hashCode ^
        currentPage.hashCode ^
        lastPage.hashCode ^
        firstPage.hashCode ^
        firstPageUrl.hashCode ^
        lastPageUrl.hashCode ^
        nextPageUrl.hashCode ^
        previousPageUrl.hashCode;
  }
}

/// [ModelRelations] enum is used to define the relations of the model.
/// other enums like [CategoryRelations] should extend this enum.
abstract class ModelRelations {}

/// [ModelFields] enum is used to define the fields of the model.
/// other enums like [CategoryFields] should extend this enum.
abstract class ModelFields {}

/// [SortOrder] enum is used to define the sort order of the model.
enum SortOrder {
  asc,
  desc,
}

/// [CollectionTemplate] is used to define the collection template of the model.
abstract class CollectionTemplate {}

/// [Auth]
abstract class AuthCollection<M extends Model, T extends AuthCredentials>
    extends Collection {
  /// [signinR]
  Future<Response<Map<String, dynamic>>> signinR(
      {RequestOptions? options}) async {
    try {
      return await manager.client.post<Map<String, dynamic>>(
        '$scope/auth/signin',
        data: options?.data,
        onReceiveProgress: options?.onReceiveProgress,
        queryParameters: options?.queryParameters,
        cancelToken: options?.cancelToken,
        options: options?.options,
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  /// [signupR]
  Future<Response<Map<String, dynamic>>> signupR(
      {RequestOptions? options}) async {
    try {
      var r = await manager.client.post<Map<String, dynamic>>(
        '$scope/auth/signup',
        data: options?.data,
        onReceiveProgress: options?.onReceiveProgress,
        queryParameters: options?.queryParameters,
        cancelToken: options?.cancelToken,
        options: options?.options,
      );
      return r;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  /// [authR] get current auth user
  Future<Response<Map<String, dynamic>>> authR(
      {RequestOptions? options}) async {
    try {
      var response = await manager.client.get<Map<String, dynamic>>(
        '$scope/auth',
        onReceiveProgress: options?.onReceiveProgress,
        queryParameters: options?.queryParameters,
        cancelToken: options?.cancelToken,
        options: options?.options,
      );
      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  /// [signoutR]
  Future<void> signoutR({RequestOptions? options}) async {
    try {
      await manager.client.post(
        '$scope/auth/signout',
        data: options?.data,
        onReceiveProgress: options?.onReceiveProgress,
        queryParameters: options?.queryParameters,
        cancelToken: options?.cancelToken,
        options: options?.options,
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  /// [signin]
  // Future<AuthResponse<M>> signin(T credentials,
  //     {RequestOptions? options}) async {
  //   options = options ?? RequestOptions();
  //   var response = await signinR(
  //     options: options.copyWithAdded(data: credentials.toMap()),
  //   );
  //   return modelFromMap(response.data!);
  // }
}

class AuthResponse<T extends Model> {
  final T model;
  final Token token;
  AuthResponse({
    required this.model,
    required this.token,
  });
}

/// [AuthCredentials]
class AuthCredentials<UT, PT> {
  /// [username]
  final UT username;

  /// [password]
  final PT password;
  const AuthCredentials({
    required this.username,
    required this.password,
  });

  AuthCredentials<UT, PT> copyWith({
    UT? username,
    PT? password,
  }) {
    return AuthCredentials<UT, PT>(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username.toString(),
      'password': password.toString(),
    };
  }

  factory AuthCredentials.fromMap(Map<String, dynamic> map) {
    return AuthCredentials<UT, PT>(
      username: map['username'] as UT,
      password: map['password'] as PT,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthCredentials.fromJson(String source) =>
      AuthCredentials.fromMap(json.decode(source));

  @override
  String toString() =>
      'AuthCredentials(username: $username, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthCredentials<UT, PT> &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}

class Token {
  final String token;
  final String type;
  Token({
    required this.token,
    required this.type,
  });

  Token copyWith({
    String? token,
    String? type,
  }) {
    return Token(
      token: token ?? this.token,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'type': type,
    };
  }

  factory Token.fromMap(Map<String, dynamic> map) {
    return Token(
      token: map['token'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Token.fromJson(String source) => Token.fromMap(json.decode(source));

  @override
  String toString() => 'Token(token: $token, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Token && other.token == token && other.type == type;
  }

  @override
  int get hashCode => token.hashCode ^ type.hashCode;
}

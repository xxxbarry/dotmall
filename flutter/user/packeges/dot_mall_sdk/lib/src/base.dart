import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';

import 'package:dot_mall_sdk/src/collections/collection.dart';

import 'collections/categories/collection.dart';

export 'collections/collection.dart';
export 'collections/collections.dart';
export 'collections/model.dart';

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
    final listEquals = const DeepCollectionEquality().equals;

    return other is ValidationException &&
        other.message == message &&
        listEquals(other.errors, errors);
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
    final mapEquals = const DeepCollectionEquality().equals;

    return other is ValidationError &&
        other.rule == rule &&
        other.field == field &&
        other.message == message &&
        mapEquals(other.args, args);
  }

  @override
  int get hashCode {
    return rule.hashCode ^ field.hashCode ^ message.hashCode ^ args.hashCode;
  }
}

// /// [Auth<T extends Collection>] is a class that provides authentication for the DotMall API.
// class Auth<T extends Collection> {
//   final T collection;
//   Token? token;
//   Auth({
//     required this.collection,
//     required this.token,
//   });

//   /// [signin] is a static method used to signin
//   /// return a [Future<Auth<T>>]
//   static Future<Auth<T>> signin<T extends Collection>(
//     String username,
//     String password,
//   ) async {
//     final token = await collection.client.post(
//       'auth/signin',
//       data: {
//         'username': username,
//         'password': password,
//       },
//     );
//     return Auth(
//       collection: collection,
//       token: Token(
//         token: token.data['token'],
//         expires: DateTime.parse(token.data['expires']),
//         type: null,
//       ),
//     );
//   }
// }

// /// [Token]
// class Token {
//   final TokenType type;
//   final String value;
//   final DateTime? expires;
//   Token({
//     required this.type,
//     required this.value,
//     this.expires,
//   });
// }

// // [TokenType] enum
// enum TokenType {
//   bearer,
//   basic,
// }

/// Configs is a class that provides configuration for the DotMallSDK.
class Configs {
  String get endpoint => mode == Mode.production ? prodEndpoint : devEndpoint;
  final String prodEndpoint;
  final String devEndpoint;
  final Mode mode;
  final Languages? language;
  final AuthCollection Function(Manager)? auth;
  Configs({
    this.prodEndpoint = "http://127.0.0.1:3333/api/v1/",
    this.devEndpoint = "http://127.0.0.1:3333/api/v1/",
    this.mode = Mode.development,
    this.language,
    this.auth,
  });

  Configs copyWith({
    String? prodEndpoint,
    String? devEndpoint,
    Mode? mode,
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
      mode: Mode.values[map['mode']],
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

/// Mode is a class that provides the mode of the DotMallSDK.
enum Mode {
  development,
  production,
}

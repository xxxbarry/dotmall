// import 'package:dio/dio.dart';
// import 'package:dotmall_sdk/dotmall_sdk.dart';
// /// [Manager] is a class that provides access to the DotMall API.
// /// It is a singleton class.
// /// It is used to make requests to the DotMall API.
// /// accept [Configs] to set the configs of the [Manager].
// class App {
//   // Auth<User>? auth = Auth<User>();

//   final Configs configs;
//   final Dio _client = Dio();
//   Dio get client => _client;

//   Manager({required this.configs}) {
//     categories = Categories(this);
//   }

//   /// Collections
//   // late final Users users;
//   late final Categories categories;
//   // late final Stores stores;
//   // late final Sections sections;
//   // late final Products products;

//   /// [init] is used to initialize the [Manager].
//   Future<void> init() async {
//     client.options.baseUrl = configs.endpoint;
//     client.options.connectTimeout = 5000;
//     client.options.receiveTimeout = 5000;
//     client.options.headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     };

//     /// intialize collections
//   }

//   _initCollections() {
//     categories.init();
//   }
// }

// // /// [Auth<T extends Collection>] is a class that provides authentication for the DotMall API.
// // class Auth<T extends Collection> {
// //   final T collection;
// //   Token? token;
// //   Auth({
// //     required this.collection,
// //     required this.token,
// //   });

// //   /// [signin] is a static method used to signin
// //   /// return a [Future<Auth<T>>]
// //   static Future<Auth<T>> signin<T extends Collection>(
// //     String username,
// //     String password,
// //   ) async {
// //     final token = await collection.client.post(
// //       'auth/signin',
// //       data: {
// //         'username': username,
// //         'password': password,
// //       },
// //     );
// //     return Auth(
// //       collection: collection,
// //       token: Token(
// //         token: token.data['token'],
// //         expires: DateTime.parse(token.data['expires']),
// //         type: null,
// //       ),
// //     );
// //   }
// // }

// // /// [Token]
// // class Token {
// //   final TokenType type;
// //   final String value;
// //   final DateTime? expires;
// //   Token({
// //     required this.type,
// //     required this.value,
// //     this.expires,
// //   });
// // }

// // // [TokenType] enum
// // enum TokenType {
// //   bearer,
// //   basic,
// // }

// /// Configs is a class that provides configuration for the DotMallSDK.
// class Configs {
//   String get endpoint => mode == Mode.production ? prodEndpoint : devEndpoint;
//   final String prodEndpoint;
//   final String devEndpoint;
//   final Mode mode;

//   Configs({
//     required this.prodEndpoint,
//     this.devEndpoint = "http://127.0.0.1:3333/api/v1/",
//     this.mode = Mode.development,
//   });
// }

// /// Mode is a class that provides the mode of the DotMallSDK.
// enum Mode {
//   development,
//   production,
// }

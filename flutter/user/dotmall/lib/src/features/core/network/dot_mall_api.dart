// import 'dart:convert';

// import 'package:dio/dio.dart';

// /// DotMallAPI is a class that provides access to the DotMall API.
// /// It is a singleton class.
// /// It is used to make requests to the DotMall API.
// class DotMallAPI {
//   static final DotMallAPI _instance = DotMallAPI._internal();
//   factory DotMallAPI() => _instance;
//   DotMallAPI._internal();
//   final Dio dio = Dio();
//   final String base = 'https://api.dotmall.com/';

//   Future<void> init() async {
//     dio.options.baseUrl = base;
//     dio.options.connectTimeout = 5000;
//     dio.options.receiveTimeout = 5000;
//     dio.options.headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     };
//   }
// }

// /// Model
// abstract class Model {
//   Map<String, dynamic> toMap();
//   String toJson() => json.encode(toMap());
// }
// class Store extends Model {
//   final String id;
//   final String name;
//   final String description;
//   Store({
//     required this.id,
//     required this.name,
//     required this.description,
//   });
  

//   Store copyWith({
//     String? id,
//     String? name,
//     String? description,
//   }) {
//     return Store(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       description: description ?? this.description,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'name': name,
//       'description': description,
//     };
//   }

//   factory Store.fromMap(Map<String, dynamic> map) {
//     return Store(
//       id: map['id'],
//       name: map['name'],
//       description: map['description'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Store.fromJson(String source) => Store.fromMap(json.decode(source));

//   @override
//   String toString() => 'Store(id: $id, name: $name, description: $description)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
  
//     return other is Store &&
//       other.id == id &&
//       other.name == name &&
//       other.description == description;
//   }

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
// }

// /// Models of DotMall API.
// /// list [User, Account, Store, StoreTranslation, Section, SectionTranslation, Product, ProductTranslation, Category, CategoryTranslation, Email, Phone, MerchantProfile, CustomerProfile]
// /// all models has 5 methods:
// /// [find, list, create, update, delete]
// /// * [find] is used to get a model by id.
// ///   - example:
// ///     ```dart
// ///     curl -X GET https://api.dotmall.app/v1/users/{user_id}
// ///     ```
// ///   - accept parameters:
// ///    * [id] is the id of the model.
// ///    * [load] is array of relations to load.
// /// * [list] is used to get a list of models.
// ///   - example:
// ///   ```dart
// ///   curl -X GET https://api.dotmall.app/v1/users
// ///   ```
// ///   - accept parameters:
// ///    * [page] is the page number.
// ///    * [limit] is the number of models per page.
// ///    * [load] is array of relations to load.
// ///    * [where] is the where clause.
// ///    * [order] is the order clause.
// ///    * [search] is the search clause.
// ///    * [search_by] is the search by clause.
// ///    * [sort] sort resuts
// /// * [create] is used to create a model.
// ///   - example:
// ///   ```dart
// ///   curl -X POST https://api.dotmall.app/v1/users -d '{ "name": "John Doe" }'
// ///   ```
// /// * [update] is used to update a model.
// ///   - example:
// ///   ```dart
// ///   curl -X PUT https://api.dotmall.app/v1/users/{user_id} -d '{ "name": "John Doe" }'
// ///   ```
// /// * [delete] is used to delete a model.
// ///   - example:
// ///   ```dart
// ///   curl -X DELETE https://api.dotmall.app/v1/users/{user_id}
// ///   ```
// abstract class Collection {
//   /// [client] is the Dio client.
//   Dio get client;

//   /// [scope] is the scope of the model.
//   String get scope;

//   /// [find] method is used to get a model by id.
//   ///  - example:
//   ///   ```dart
//   ///   curl -X GET https://api.dotmall.app/v1/users/{user_id}
//   ///   ```
//   ///   - accept parameters:
//   ///   * [load] is array of relations to load.
//   Future<Model> find({required String id, CollectionRequestOptions? options});
//   // Future<Model> find({required String id, CollectionRequestOptions? options}) async {
//   //   var response = await client.get(
//   //     '$scope/$id',
//   //     onReceiveProgress: options?.onReceiveProgress,
//   //     queryParameters: options?.queryParameters,
//   //     cancelToken: options?.cancelToken,
//   //     options: options?.options,
//   //   );
//   //   return T.fromJson(response.data);

//   //   // response = await client.post(
//   //   //   '$scope/$id',
//   //   //   data: {'aa': 'bb' * 22},
//   //   //   onSendProgress: options?.onSendProgress,
//   //   //   onReceiveProgress: options?.onReceiveProgress,
//   //   //   queryParameters: options?.queryParameters,
//   //   // );
//   // }
// }
// class StoreCollection extends Collection {
//   StoreCollection(this.client);
//   final Dio client;
//   @override
//   String get scope => 'stores';
//   @override
//   Future<Store> find({required String id, StoreRequestOptions? options}) async {
//     var response = await client.get(
//       '$scope/$id',
//       onReceiveProgress: options?.onReceiveProgress,
//       queryParameters: options?.queryParameters,
//       cancelToken: options?.cancelToken,
//       options: options?.options,
//     );
//     return Store.fromJson(response.data);
//   }
// }
// class StoreRequestOptions extends CollectionRequestOptions {
//   StoreRequestOptions({
//     Map<String, dynamic>? queryParameters,
//     CancelToken? cancelToken,
//     ProgressCallback? onReceiveProgress,
//     ProgressCallback? onSendProgress,
//     Options? options,
//   });
  
//   @override
//   // TODO: implement data
//   get data => throw UnimplementedError();
  
//   @override
//   // TODO: implement queryParameters
//   Map<String, dynamic>? get queryParameters => throw UnimplementedError();
  
//   @override
//   Map<String, dynamic> toJson() {
//     // TODO: implement toJson
//     throw UnimplementedError();
//   }
// }
// abstract class CollectionRequestOptions {
//   void Function(int, int)? onSendProgress;
//   void Function(int, int)? onReceiveProgress;
//   Map<String, dynamic>? get queryParameters;
//   dynamic get data;
//   CancelToken? get cancelToken => null;
//   Options? get options => null;
//   Map<String, dynamic> toJson();
// }















// // /// ModelContainer is a abstract class that provides access to the DotMall API.
// // /// Data models like [User, Account, Store, StoreTranslation, Section, SectionTranslation, Product, ProductTranslation, Category, CategoryTranslation, Email, Phone, MerchantProfile, CustomerProfile]
// // /// must extend this class.
// // abstract class ModelContainer {
// //   Map<String, DataType> get feilds;
// // }

// // enum DataType { text, file }

// // //
// // class User implements ModelContainer {
// //   final String id;
// //   final String password;
  
// //   @override
// //   Map<String, DataType> get feilds => {
// //     'id': DataType.text,
// //     'password': DataType.text,
// //   };
// // }

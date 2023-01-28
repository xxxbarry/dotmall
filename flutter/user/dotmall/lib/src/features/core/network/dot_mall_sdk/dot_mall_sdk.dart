// import 'dart:convert';

// import 'package:dio/dio.dart';

// /// DotMallAPI is a class that provides access to the DotMall API.
// /// It is a singleton class.
// /// It is used to make requests to the DotMall API.
// class DotMallSDK {
//   final String base = 'https://api.dotmall.com/';
//   final Dio _dio = Dio();
//   Dio get dio => _dio;

//   DotMallSDK() {
//     _dio.options.baseUrl = 'http://127.0.0.1:3333/';
//     _dio.options.connectTimeout = 20000;
//     _dio.options.receiveTimeout = 20000;
//     _dio.options.headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     };
//   }

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
//   /// [client] is the Dio client.
//   Dio get client;

//   /// [scope] is the scope of the model.
//   String get scope;
// }

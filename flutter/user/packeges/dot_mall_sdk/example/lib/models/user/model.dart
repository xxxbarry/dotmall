import 'package:annotations/annotations.dart';
import 'package:dio/dio.dart' hide RequestOptions;

import 'package:dot_mall_sdk/dot_mall_sdk.dart';

import '../account/model.dart';
import '../email/model.dart';
import '../file/model.dart';
import '../phone/model.dart';

part 'model.g.dart';

@Table(auth: true)
class User extends Model {
  @Column.primary()
  final String id;

  @HasMany(from: "Account")
  final List<Account> accounts;

  @HasMany(from: "Email")
  final List<Email> emails;

  @HasMany(from: "Phone")
  final List<Phone> phones;

  @Column.required(secret: true)
  final String? password;

  @Column.auto()
  final DateTime? createdAt;
  @Column.auto()
  final DateTime? updatedAt;

  User({
    required this.id,
    this.accounts = const [],
    this.emails = const [],
    this.phones = const [],
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromMap(Map<String, dynamic> map) => Users.modelFromMap(map);
  Map<String, dynamic> toMap() => Users.modelToMap(this);

  @override
  Future signin(String username, String password) {
    throw UnimplementedError();
  }
}

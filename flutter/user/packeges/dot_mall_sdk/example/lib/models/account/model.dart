import 'package:annotations/annotations.dart';
import 'package:dio/dio.dart' hide RequestOptions;

import 'package:dot_mall_sdk/dot_mall_sdk.dart';

import '../file/model.dart';

part 'model.g.dart';

@Table(useTranslations: true)
class Account extends Model {
  @Column.primary()
  final String id;
  @Column.required()
  final String name;
  @Column()
  final String? description;
  @Column.required()
  final String userId;
  // type
  @Column()
  final AccountType type;
  // data
  @Column()
  final Map<String, dynamic>? data;

  @HasMany(from: "File")
  final List<File> photos;

  @Column.auto()
  final DateTime? createdAt;
  @Column.auto()
  final DateTime? updatedAt;
  @Column()
  final DateTime? validatedAt;
  @Column()
  final DateTime? deletedAt;

  Account({
    required this.id,
    required this.name,
    this.description,
    required this.userId,
    required this.type,
    this.data,
    this.photos = const [],
    this.createdAt,
    this.updatedAt,
    this.validatedAt,
    this.deletedAt,
  });

  factory Account.fromMap(Map<String, dynamic> map) =>
      Accounts.modelFromMap(map);
  Map<String, dynamic> toMap() => Accounts.modelToMap(this);
}

enum AccountType {
  business,
  personal,
}

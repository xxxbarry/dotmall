import 'package:annotations/annotations.dart';
import 'package:dio/dio.dart' hide RequestOptions;
import 'package:dot_mall_sdk/dot_mall_sdk.dart';

import '../category_translation/model.dart';
import '../file/model.dart';
import '../store_translation/model.dart';

part 'model.g.dart';

@Table(useTranslations: true)
class Store extends Model {
  @Column.primary()
  final String id;
  @Column.required()
  final String name;
  @Column()
  final String? description;
  @Column.auto()
  final int status;

  //accountId
  @Column.required()
  final String merchantProfileId;

  @HasMany(from: "File")
  final List<File> photos;

  @HasMany(from: "StoreTranslation")
  final List<StoreTranslation> translations;

  @Column()
  final DateTime? createdAt;
  @Column()
  final DateTime? updatedAt;
  @Column()
  final DateTime? validatedAt;
  @Column()
  final DateTime? deletedAt;

  Store({
    required this.id,
    required this.merchantProfileId,
    required this.name,
    this.description,
    required this.status,
    this.photos = const [],
    this.translations = const [],
    this.createdAt,
    this.updatedAt,
    this.validatedAt,
    this.deletedAt,
  });

  factory Store.fromMap(Map<String, dynamic> map) => Stores.modelFromMap(map);
  Map<String, dynamic> toMap() => Stores.modelToMap(this);
}

enum StoreStatus {
  panding,
  active,
  inactive,
  suspended,
}

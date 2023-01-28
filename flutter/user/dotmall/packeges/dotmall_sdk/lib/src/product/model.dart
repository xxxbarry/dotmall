import 'package:auto_sdk_annotations/auto_sdk_annotations.dart';
import 'package:dio/dio.dart' hide RequestOptions;

import 'package:auto_sdk_core/auto_sdk_core.dart';

import '../file/model.dart';
import '../product_translation/model.dart';

part 'model.g.dart';

@Table(useTranslations: true)
class Product extends Model {
  @Column.primary()
  final String id;
  @Column.required()
  final String name;
  @Column()
  final String? description;
  @Column()
  final String? slug;
  @Column()
  final String? body;
  @Column.required()
  final String storeId;
  @Column()
  final String? sectionId;
  @Column()
  final ProductType? type;
  @Column()
  final ProductStatus status;
  @Column()
  final int quantity;
  @Column()
  final String? barcode;
  @Column()
  final double? price;
  @Column()
  final Map? meta;
  @HasMany(from: "File")
  final List<File> photos;
  @HasMany(from: "ProductTranslation")
  final List<ProductTranslation> translations;
  @Column()
  final DateTime? createdAt;
  @Column()
  final DateTime? updatedAt;
  @Column()
  final DateTime? deletedAt;
  @Column()
  final DateTime? validatedAt;
  Product({
    required this.id,
    required this.name,
    required this.quantity,
    this.description,
    this.slug,
    this.body,
    required this.storeId,
    this.sectionId,
    this.type,
    required this.status,
    this.barcode,
    this.price,
    this.meta,
    this.photos = const [],
    this.translations = const [],
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.validatedAt,
  });

  factory Product.fromMap(Map<String, dynamic> map) =>
      Products.modelFromMap(map);
  Map<String, dynamic> toMap() => Products.modelToMap(this);
}

enum ProductType {
  product,
  // service,
}

enum ProductStatus {
  draft,
  published,
  archived,
  suspended,
}

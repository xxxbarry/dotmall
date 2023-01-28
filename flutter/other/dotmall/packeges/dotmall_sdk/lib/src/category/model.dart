import 'package:auto_sdk_annotations/auto_sdk_annotations.dart';
import 'package:dio/dio.dart' hide RequestOptions;
import 'package:auto_sdk_core/auto_sdk_core.dart';

import '../category_translation/model.dart';
import '../file/model.dart';

part 'model.g.dart';

@Table(
  useTranslations: true,
  semantics: SemanticCardMetaData(
    title: 'name',
    subtitle: 'description',
    image: 'photos[0]',
  ),
)
class Category extends Model {
  @Column.primary()
  final String id;
  @Column.required()
  final String name;
  @Column()
  final String? description;
  @Column()
  final String? slug;

  @HasMany(from: "File")
  final List<File> photos;

  @HasMany(from: "CategoryTranslation")
  final List<CategoryTranslation> translations;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  Category(
      {required this.id,
      required this.name,
      this.photos = const [],
      this.translations = const [],
      this.description,
      this.slug,
      this.createdAt,
      this.updatedAt});

  factory Category.fromMap(Map<String, dynamic> map) =>
      Categories.modelFromMap(map);
  Map<String, dynamic> toMap() => Categories.modelToMap(this);
}

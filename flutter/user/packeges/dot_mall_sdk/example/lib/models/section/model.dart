import 'package:annotations/annotations.dart';
import 'package:dio/dio.dart' hide RequestOptions;
import 'package:dot_mall_sdk/dot_mall_sdk.dart';

import '../section_translation/model.dart';
import '../file/model.dart';

part 'model.g.dart';

@Table(useTranslations: true)
class Section extends Model {
  @Column.primary()
  final String id;
  @Column.required()
  final String name;
  @Column()
  final String? description;
  @Column()
  final String? slug;
  @Column.required()
  final String storeId;

  @HasMany(from: "File")
  final List<File> photos;

  @HasMany(from: "SectionTranslation")
  final List<SectionTranslation> translations;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  Section(
      {required this.id,
      required this.name,
      required this.storeId,
      this.photos = const [],
      this.translations = const [],
      this.description,
      this.slug,
      this.createdAt,
      this.updatedAt});

  factory Section.fromMap(Map<String, dynamic> map) =>
      Sections.modelFromMap(map);
  Map<String, dynamic> toMap() => Sections.modelToMap(this);
}

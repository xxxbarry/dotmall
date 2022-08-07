import 'package:annotations/annotations.dart';
import 'package:dio/dio.dart' hide RequestOptions;
import 'package:dot_mall_sdk/dot_mall_sdk.dart';

part 'model.g.dart';

@Table()
class CategoryTranslation extends Model implements ModelTranslation {
  @Column.primary()
  final String id;
  @Column.required()
  final Languages locale;
  @Column()
  final String name;
  @Column()
  final String? description;
  @Column.required()
  final String categoryId;
  CategoryTranslation({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
    required this.locale,
  });
  factory CategoryTranslation.fromMap(Map<String, dynamic> map) =>
      CategoryTranslations.modelFromMap(map);
  Map<String, dynamic> toMap() => CategoryTranslations.modelToMap(this);
}

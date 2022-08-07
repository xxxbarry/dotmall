import 'package:annotations/annotations.dart';
import 'package:dio/dio.dart' hide RequestOptions;

import 'package:dot_mall_sdk/dot_mall_sdk.dart';

part 'model.g.dart';

@Table(useTranslations: true)
class Phone extends Model {
  @Column.primary()
  final String id;

  @Column.required()
  final String value;

  @Column.auto()
  final DateTime? createdAt;
  @Column.auto()
  final DateTime? updatedAt;

  Phone({
    required this.id,
    required this.value,
    this.createdAt,
    this.updatedAt,
  });

  factory Phone.fromMap(Map<String, dynamic> map) => Phones.modelFromMap(map);
  @override
  Map<String, dynamic> toMap() => Phones.modelToMap(this);
}

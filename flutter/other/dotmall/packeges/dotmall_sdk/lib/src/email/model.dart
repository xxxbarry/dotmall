import 'package:auto_sdk_annotations/auto_sdk_annotations.dart';
import 'package:dio/dio.dart' hide RequestOptions;

import 'package:auto_sdk_core/auto_sdk_core.dart';

part 'model.g.dart';

@Table(useTranslations: true)
class Email extends Model {
  @Column(primary: true)
  final String id;
  @Column()
  final String value;
  @Column()
  final DateTime? createdAt;
  @Column()
  final DateTime? updatedAt;

  Email({
    required this.id,
    required this.value,
    this.createdAt,
    this.updatedAt,
  });

  factory Email.fromMap(Map<String, dynamic> map) => Emails.modelFromMap(map);
  @override
  Map<String, dynamic> toMap() => Emails.modelToMap(this);
}

import 'package:auto_sdk_annotations/auto_sdk_annotations.dart';
import 'package:dio/dio.dart' hide RequestOptions;

import 'package:auto_sdk_core/auto_sdk_core.dart';

import '../file/model.dart';

part 'model.g.dart';

@Table()
class CustomerProfile extends Model {
  @Column.primary()
  final String id;
  @Column.required()
  final String accountId;
  @Column()
  final DateTime? deletedAt;
  @Column()
  final DateTime? validatedAt;
  CustomerProfile({
    required this.id,
    required this.accountId,
    this.deletedAt,
    this.validatedAt,
  });

  factory CustomerProfile.fromMap(Map<String, dynamic> map) =>
      CustomerProfiles.modelFromMap(map);
  Map<String, dynamic> toMap() => CustomerProfiles.modelToMap(this);
}

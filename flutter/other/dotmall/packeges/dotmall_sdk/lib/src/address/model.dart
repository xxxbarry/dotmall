import 'package:auto_sdk_annotations/auto_sdk_annotations.dart';
import 'package:auto_sdk_core/auto_sdk_core.dart';
import 'package:dio/dio.dart' hide RequestOptions;

import '../../dotmall_sdk.dart';

part 'model.g.dart';

@Table()
class Address extends Model {
  @Column.required()
  final String userId;
  @Column.primary()
  final String id;
  @Column.required()
  final String primary;
  @Column()
  final String? secondary;
  @Column()
  final String? city;
  @Column()
  final String? state;
  @Column()
  final String? zip;
  @Column()
  final String? country;
  @Column()
  final double? latitude;
  @Column()
  final double? longitude;

  @Column()
  final DateTime? createdAt;
  @Column()
  final DateTime? updatedAt;
  @Column()
  final DateTime? validatedAt;
  @Column()
  final DateTime? deletedAt;

  Address({
    required this.userId,
    required this.id,
    required this.primary,
    this.secondary,
    this.city,
    this.state,
    this.zip,
    this.country,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.validatedAt,
    this.deletedAt,
  });

  factory Address.fromMap(Map<String, dynamic> map) =>
      Addresses.modelFromMap(map);
  Map<String, dynamic> toMap() => Addresses.modelToMap(this);
}

enum AddressType {
  business,
  personal,
}

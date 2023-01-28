import 'package:auto_sdk_annotations/auto_sdk_annotations.dart';
import 'package:auto_sdk_core/auto_sdk_core.dart';
import 'package:dio/dio.dart' hide RequestOptions;

import '../address/model.dart';
import '../customer_profile/model.dart';
import '../file/model.dart';
import '../order_item/model.dart';

part 'model.g.dart';

@Table()
class Order extends Model {
  @Column.primary()
  final String id;
  @Column.required()
  final String addressId;
  @Column.required()
  final String customerProfileId;
  @Column()
  final OrderStatus status;

  @Column()
  final DateTime? createdAt;
  @Column()
  final DateTime? updatedAt;
  @Column()
  final DateTime? validatedAt;
  @Column()
  final DateTime? deletedAt;
  @Column()
  final DateTime? closedAt;

  @HasMany(from: "OrderItem")
  final List<OrderItem>? orderItems;

  @HasOne(from: "Address")
  final Address? address;

  @HasOne(from: "CustomerProfile")
  final CustomerProfile? customerProfile;

  Order({
    required this.id,
    required this.addressId,
    required this.customerProfileId,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.validatedAt,
    this.deletedAt,
    this.closedAt,
    this.orderItems,
    this.address,
    this.customerProfile,
  });

  factory Order.fromMap(Map<String, dynamic> map) => Orders.modelFromMap(map);
  Map<String, dynamic> toMap() => Orders.modelToMap(this);
}

enum OrderStatus {
  pending,
  active,
  inactive,
  suspended,
}

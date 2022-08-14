import 'package:auto_sdk_annotations/auto_sdk_annotations.dart';
import 'package:auto_sdk_core/auto_sdk_core.dart';
import 'package:dio/dio.dart' hide RequestOptions;

import '../file/model.dart';

part 'model.g.dart';

@Table()
class OrderItem extends Model {
  @Column.primary()
  final String id;
  @Column.required()
  final String orderId;
  @Column.required()
  final String productId;
  @Column()
  final int quantity;
  @Column()
  final double price;
  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
  });
  factory OrderItem.fromMap(Map<String, dynamic> map) =>
      OrderItems.modelFromMap(map);
  @override
  Map<String, dynamic> toMap() => OrderItems.modelToMap(this);
}

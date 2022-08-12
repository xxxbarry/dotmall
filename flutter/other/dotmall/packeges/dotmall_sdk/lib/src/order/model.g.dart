// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TableAnnotationGenerator
// **************************************************************************

// Orders
class Orders extends Collection<Order> {
  Orders(this.manager);

  final Manager manager;

  final String table = "orders";

  final String scope = "orders";

  Orders copyWith({Manager? manager}) {
    return Orders(manager ?? this.manager);
  }

  Orders copyWithConfigs(Configs? configs) {
    return Orders(this.manager.copyWith(configs: configs));
  }

  static Order modelFromMap(Map<String, dynamic> map) {
    return Order(
      id: map["id"],
      addressId: map["address_id"],
      customerProfileId: map["customer_profile_id"],
      status: OrderStatus.values[map["status"]],
      createdAt: DateTime.tryParse(map["created_at"].toString()),
      updatedAt: DateTime.tryParse(map["updated_at"].toString()),
      validatedAt: DateTime.tryParse(map["validated_at"].toString()),
      deletedAt: DateTime.tryParse(map["deleted_at"].toString()),
      closedAt: DateTime.tryParse(map["closed_at"].toString()),
      orderItems: [
        for (var item in map["order_items"] ?? []) OrderItems.modelFromMap(item)
      ],
      address: Addresses.modelFromMap(map["address"]),
      customerProfile: CustomerProfiles.modelFromMap(map["customer_profile"]),
    );
  }

  static Map<String, dynamic> modelToMap(Order order) {
    return {
      "id": order.id,
      "address_id": order.addressId,
      "customer_profile_id": order.customerProfileId,
      "status": order.status.index,
      "created_at": order.createdAt,
      "updated_at": order.updatedAt,
      "validated_at": order.validatedAt,
      "deleted_at": order.deletedAt,
      "closed_at": order.closedAt,
      "order_items": [
        for (var item in order.orderItems ?? []) item?.modelToMap()
      ],
      "address": order.address?.toMap(),
      "customer_profile": order.customerProfile?.toMap(),
    };
  }

  Future<Order> find(String id,
      {List<OrderRelations>? load, RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await findR(
        id,
        options: options.copyWithAdded(
          queryParameters: {
            'load': load?.map((e) => e.name).toList(),
          },
        ),
      );
      return modelFromMap(response.data!["order"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<void> delete(String id,
      {List<OrderRelations>? load, RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await findR(
        id,
        options: options,
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<Order> create(
      {required String addressId,
      required String customerProfileId,
      required OrderStatus status,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? validatedAt,
      DateTime? deletedAt,
      DateTime? closedAt,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await createR(
        options: options.copyWithAdded(data: {
          if (addressId != null) 'address_id': addressId,
          if (customerProfileId != null)
            'customer_profile_id': customerProfileId,
          if (status != null) 'status': status.index,
          if (createdAt != null) 'created_at': createdAt,
          if (updatedAt != null) 'updated_at': updatedAt,
          if (validatedAt != null) 'validated_at': validatedAt,
          if (deletedAt != null) 'deleted_at': deletedAt,
          if (closedAt != null) 'closed_at': closedAt,
        }),
      );
      return modelFromMap(response.data!["order"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<Order> update(String id,
      {String? addressId,
      String? customerProfileId,
      OrderStatus? status,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? validatedAt,
      DateTime? deletedAt,
      DateTime? closedAt,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await updateR(
        id,
        options: options.copyWithAdded(
          data: {
            if (addressId != null) 'address_id': addressId,
            if (customerProfileId != null)
              'customer_profile_id': customerProfileId,
            if (status != null) 'status': status.index,
            if (createdAt != null) 'created_at': createdAt,
            if (updatedAt != null) 'updated_at': updatedAt,
            if (validatedAt != null) 'validated_at': validatedAt,
            if (deletedAt != null) 'deleted_at': deletedAt,
            if (closedAt != null) 'closed_at': closedAt
          },
        ),
      );
      return modelFromMap(response.data!["order"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<PaginatedOrder> list(
      {List<OrderRelations>? load,
      int? page = 1,
      int? limit = 24,
      OrderSortables? sort,
      SortOrder? order,
      String? search,
      OrderSearchables? searchIn,
      Map<OrderFields, String>? where,
      RequestOptions? options}) async {
    try {
      assert(
          (search == null && searchIn == null) ||
              (search != null && searchIn != null),
          'search and searchIn must be used together');
      options = options ?? RequestOptions();
      var response = await listR(
          options: options.copyWithAdded(queryParameters: {
        if (page != null) 'page': page.toString(),
        if (limit != null) 'limit': limit.toString(),
        if (sort != null) 'sort': sort.name,
        if (order != null) 'order': order.name,
        if (search != null) 'search': search,
        if (searchIn != null) 'searchIn': searchIn.name,
        // [where] is a map of [OrderFields] and [String], it should convert to a map of [String] and [String].
        if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
        if (load != null) 'load': load.map((e) => e.name).toList()
      }));
      return PaginatedOrder.fromMap(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }
}

// OrderRelations
enum OrderRelations { orderItems, address, customerProfile }

// OrderFilterables
enum OrderFilterables {
  id,
  addressId,
  customerProfileId,
  status,
  createdAt,
  updatedAt,
  validatedAt,
  deletedAt,
  closedAt
}

// OrderSortables
enum OrderSortables {
  id,
  addressId,
  customerProfileId,
  status,
  createdAt,
  updatedAt,
  validatedAt,
  deletedAt,
  closedAt
}

// OrderSearchables
enum OrderSearchables {
  id,
  addressId,
  customerProfileId,
  status,
  createdAt,
  updatedAt,
  validatedAt,
  deletedAt,
  closedAt
}

// OrderFields
enum OrderFields {
  id,
  addressId,
  customerProfileId,
  status,
  createdAt,
  updatedAt,
  validatedAt,
  deletedAt,
  closedAt
}

// OrderTranslatables
// no fields
// OrderAuthCredentials
// no fields
// PaginatedOrder
class PaginatedOrder extends PaginatedModel {
  PaginatedOrder({required this.data, required this.meta});

  final List<Order> data;

  final PaginationMeta meta;

  static PaginatedOrder fromMap(Map<String, dynamic> map) {
    return PaginatedOrder(
      data: List<Order>.from(map['data'].map((x) => Order.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TableAnnotationGenerator
// **************************************************************************

// Products
class Products extends Collection<Product> {
  Products(this.manager);

  final Manager manager;

  final String table = "products";

  final String scope = "products";

  static Product modelFromMap(Map<String, dynamic> map) {
    return Product(
      id: map["id"],
      name: map["name"],
      description: map["description"],
      slug: map["slug"],
      body: map["body"],
      storeId: map["store_id"],
      sectionId: map["section_id"],
      type: ProductType.values[map["type"]],
      status: ProductStatus.values[map["status"]],
      quantity: map["quantity"],
      barcode: map["barcode"],
      price: double.tryParse(map["price"].toString()),
      meta: map["meta"],
      createdAt: DateTime.tryParse(map["created_at"].toString()),
      updatedAt: DateTime.tryParse(map["updated_at"].toString()),
      deletedAt: DateTime.tryParse(map["deleted_at"].toString()),
      validatedAt: DateTime.tryParse(map["validated_at"].toString()),
      photos: [for (var item in map["photos"] ?? []) Files.modelFromMap(item)],
      translations: [
        for (var item in map["translations"] ?? [])
          ProductTranslations.modelFromMap(item)
      ],
    );
  }

  static Map<String, dynamic> modelToMap(Product product) {
    return {
      "id": product.id,
      "name": product.name,
      "description": product.description,
      "slug": product.slug,
      "body": product.body,
      "store_id": product.storeId,
      "section_id": product.sectionId,
      "type": product.type?.index,
      "status": product.status.index,
      "quantity": product.quantity,
      "barcode": product.barcode,
      "price": product.price,
      "meta": product.meta,
      "created_at": product.createdAt,
      "updated_at": product.updatedAt,
      "deleted_at": product.deletedAt,
      "validated_at": product.validatedAt,
      "photos": [for (var item in product.photos ?? []) item.modelToMap()],
      "translations": [
        for (var item in product.translations ?? []) item.modelToMap()
      ],
    };
  }

  Future<Product> find(String id,
      {List<ProductRelations>? load, RequestOptions? options}) async {
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
      return modelFromMap(response.data!["product"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<void> delete(String id,
      {List<ProductRelations>? load, RequestOptions? options}) async {
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

  Future<Product> create(
      {required String name,
      String? description,
      String? slug,
      String? body,
      required String storeId,
      String? sectionId,
      ProductType? type,
      required ProductStatus status,
      required int quantity,
      String? barcode,
      double? price,
      Map<dynamic, dynamic>? meta,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt,
      DateTime? validatedAt,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await createR(
        options: options.copyWithAdded(data: {
          if (name != null) 'name': name,
          if (description != null) 'description': description,
          if (slug != null) 'slug': slug,
          if (body != null) 'body': body,
          if (storeId != null) 'store_id': storeId,
          if (sectionId != null) 'section_id': sectionId,
          if (type != null) 'type': type.index,
          if (status != null) 'status': status.index,
          if (quantity != null) 'quantity': quantity,
          if (barcode != null) 'barcode': barcode,
          if (price != null) 'price': price,
          if (meta != null) 'meta': meta,
          if (createdAt != null) 'created_at': createdAt,
          if (updatedAt != null) 'updated_at': updatedAt,
          if (deletedAt != null) 'deleted_at': deletedAt,
          if (validatedAt != null) 'validated_at': validatedAt,
        }),
      );
      return modelFromMap(response.data!["product"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<Product> update(String id,
      {String? name,
      String? description,
      String? slug,
      String? body,
      String? storeId,
      String? sectionId,
      ProductType? type,
      ProductStatus? status,
      int? quantity,
      String? barcode,
      double? price,
      Map<dynamic, dynamic>? meta,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt,
      DateTime? validatedAt,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await updateR(
        id,
        options: options.copyWithAdded(
          data: {
            if (name != null) 'name': name,
            if (description != null) 'description': description,
            if (slug != null) 'slug': slug,
            if (body != null) 'body': body,
            if (storeId != null) 'store_id': storeId,
            if (sectionId != null) 'section_id': sectionId,
            if (type != null) 'type': type.index,
            if (status != null) 'status': status.index,
            if (quantity != null) 'quantity': quantity,
            if (barcode != null) 'barcode': barcode,
            if (price != null) 'price': price,
            if (meta != null) 'meta': meta,
            if (createdAt != null) 'created_at': createdAt,
            if (updatedAt != null) 'updated_at': updatedAt,
            if (deletedAt != null) 'deleted_at': deletedAt,
            if (validatedAt != null) 'validated_at': validatedAt
          },
        ),
      );
      return modelFromMap(response.data!["product"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<PaginatedProduct> list(
      {List<ProductRelations>? load,
      int? page = 1,
      int? limit = 24,
      ProductSortables? sort,
      SortOrder? order,
      String? search,
      ProductSearchables? searchIn,
      Map<ProductFields, String>? where,
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
        // [where] is a map of [ProductFields] and [String], it should convert to a map of [String] and [String].
        if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
        if (load != null) 'load': load.map((e) => e.name).toList()
      }));
      return PaginatedProduct.fromMap(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }
}

// ProductRelations
enum ProductRelations { photos, translations }

// ProductFilterables
enum ProductFilterables {
  id,
  name,
  description,
  slug,
  body,
  storeId,
  sectionId,
  type,
  status,
  quantity,
  barcode,
  price,
  meta,
  createdAt,
  updatedAt,
  deletedAt,
  validatedAt
}

// ProductSortables
enum ProductSortables {
  id,
  name,
  description,
  slug,
  body,
  storeId,
  sectionId,
  type,
  status,
  quantity,
  barcode,
  price,
  meta,
  createdAt,
  updatedAt,
  deletedAt,
  validatedAt
}

// ProductSearchables
enum ProductSearchables {
  id,
  name,
  description,
  slug,
  body,
  storeId,
  sectionId,
  type,
  status,
  quantity,
  barcode,
  price,
  meta,
  createdAt,
  updatedAt,
  deletedAt,
  validatedAt
}

// ProductFields
enum ProductFields {
  id,
  name,
  description,
  slug,
  body,
  storeId,
  sectionId,
  type,
  status,
  quantity,
  barcode,
  price,
  meta,
  createdAt,
  updatedAt,
  deletedAt,
  validatedAt
}

// ProductTranslatables
// no fields
// ProductAuthCredentials
// no fields
// PaginatedProduct
class PaginatedProduct extends PaginatedModel {
  PaginatedProduct({required this.data, required this.meta});

  final List<Product> data;

  final PaginationMeta meta;

  static PaginatedProduct fromMap(Map<String, dynamic> map) {
    return PaginatedProduct(
      data: List<Product>.from(map['data'].map((x) => Product.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }
}

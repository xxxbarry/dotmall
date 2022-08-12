// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TableAnnotationGenerator
// **************************************************************************

// Phones
class Phones extends Collection<Phone> {
  Phones(this.manager);

  final Manager manager;

  final String table = "phones";

  final String scope = "phones";

  Phones copyWith({Manager? manager}) {
    return Phones(manager ?? this.manager);
  }

  Phones copyWithConfigs(Configs? configs) {
    return Phones(this.manager.copyWith(configs: configs));
  }

  static Phone modelFromMap(Map<String, dynamic> map) {
    return Phone(
      id: map["id"],
      value: map["value"],
      createdAt: DateTime.tryParse(map["created_at"].toString()),
      updatedAt: DateTime.tryParse(map["updated_at"].toString()),
    );
  }

  static Map<String, dynamic> modelToMap(Phone phone) {
    return {
      "id": phone.id,
      "value": phone.value,
      "created_at": phone.createdAt,
      "updated_at": phone.updatedAt,
    };
  }

  Future<Phone> find(String id, {RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await findR(
        id,
        options: options.copyWithAdded(
          queryParameters: {},
        ),
      );
      return modelFromMap(response.data!["phone"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<void> delete(String id, {RequestOptions? options}) async {
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

  Future<Phone> create({required String value, RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await createR(
        options: options.copyWithAdded(data: {
          if (value != null) 'value': value,
        }),
      );
      return modelFromMap(response.data!["phone"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<Phone> update(String id,
      {String? value,
      DateTime? createdAt,
      DateTime? updatedAt,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await updateR(
        id,
        options: options.copyWithAdded(
          data: {
            if (value != null) 'value': value,
            if (createdAt != null) 'created_at': createdAt,
            if (updatedAt != null) 'updated_at': updatedAt
          },
        ),
      );
      return modelFromMap(response.data!["phone"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<PaginatedPhone> list(
      {int? page = 1,
      int? limit = 24,
      PhoneSortables? sort,
      SortOrder? order,
      String? search,
      PhoneSearchables? searchIn,
      Map<PhoneFields, String>? where,
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
        // [where] is a map of [PhoneFields] and [String], it should convert to a map of [String] and [String].
        if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
      }));
      return PaginatedPhone.fromMap(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }
}

// PhoneRelations
// no relations
// PhoneFilterables
enum PhoneFilterables { id, value, createdAt, updatedAt }

// PhoneSortables
enum PhoneSortables { id, value, createdAt, updatedAt }

// PhoneSearchables
enum PhoneSearchables { id, value, createdAt, updatedAt }

// PhoneFields
enum PhoneFields { id, value, createdAt, updatedAt }

// PhoneTranslatables
// no fields
// PhoneAuthCredentials
// no fields
// PaginatedPhone
class PaginatedPhone extends PaginatedModel {
  PaginatedPhone({required this.data, required this.meta});

  final List<Phone> data;

  final PaginationMeta meta;

  static PaginatedPhone fromMap(Map<String, dynamic> map) {
    return PaginatedPhone(
      data: List<Phone>.from(map['data'].map((x) => Phone.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }
}

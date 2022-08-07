// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TableAnnotationGenerator
// **************************************************************************

// Emails
class Emails extends Collection<Email> {
  Emails(this.manager);

  final Manager manager;

  final String table = "emails";

  final String scope = "emails";

  static Email modelFromMap(Map<String, dynamic> map) {
    return Email(
      id: map["id"],
      value: map["value"],
      createdAt: DateTime.tryParse(map["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(map["updated_at"] ?? ""),
    );
  }

  static Map<String, dynamic> modelToMap(Email email) {
    return {
      "id": email.id,
      "value": email.value,
      "created_at": email.createdAt,
      "updated_at": email.updatedAt,
    };
  }

  Future<Email> find(String id, {RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await findR(
        id,
        options: options.copyWithAdded(
          queryParameters: {},
        ),
      );
      return modelFromMap(response.data!["email"]);
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

  Future<Email> create(
      {required String id,
      required String value,
      DateTime? createdAt,
      DateTime? updatedAt,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await createR(
        options: options.copyWithAdded(data: {
          if (id != null) 'id': id,
          if (value != null) 'value': value,
          if (createdAt != null) 'created_at': createdAt,
          if (updatedAt != null) 'updated_at': updatedAt,
        }),
      );
      return modelFromMap(response.data!["email"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<Email> update(String id,
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
      return modelFromMap(response.data!["email"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<PaginatedEmail> list(
      {int? page = 1,
      int? limit = 24,
      EmailSortables? sort,
      SortOrder? order,
      String? search,
      EmailSearchables? searchIn,
      Map<EmailFields, String>? where,
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
        // [where] is a map of [EmailFields] and [String], it should convert to a map of [String] and [String].
        if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
      }));
      return PaginatedEmail.fromMap(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }
}

// EmailRelations
// no relations
// EmailFilterables
enum EmailFilterables { id, value, createdAt, updatedAt }

// EmailSortables
enum EmailSortables { id, value, createdAt, updatedAt }

// EmailSearchables
enum EmailSearchables { id, value, createdAt, updatedAt }

// EmailFields
enum EmailFields { id, value, createdAt, updatedAt }

// EmailTranslatables
// no fields
// EmailAuthCredentials
// no fields
// PaginatedEmail
class PaginatedEmail extends PaginatedModel {
  PaginatedEmail({required this.data, required this.meta});

  final List<Email> data;

  final PaginationMeta meta;

  static PaginatedEmail fromMap(Map<String, dynamic> map) {
    return PaginatedEmail(
      data: List<Email>.from(map['data'].map((x) => Email.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }
}

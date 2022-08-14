// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TableAnnotationGenerator
// **************************************************************************

/// Files
class Files extends Collection<File> {
  Files(this.manager);

  final Manager manager;

  final String table = "files";

  final String scope = "files";

  SemanticCardMetaData semanticsOf(File model) {
    return SemanticCardMetaData<String?, String?, File?>(
      title: null,
      subtitle: null,
      image: null,
    );
  }

  @override
  PaginatedModel<File> paginatedModelFromMap(Map<String, dynamic> map) {
    return PaginatedFile.fromMap(map);
  }

  Files copyWith({Manager? manager}) {
    return Files(manager ?? this.manager);
  }

  Files copyWithConfigs(Configs? configs) {
    return Files(this.manager.copyWith(configs: configs));
  }

  static File modelFromMap(Map<String, dynamic> map) {
    return File(
      id: map["id"],
      name: map["name"],
      description: map["description"],
      path: map["path"],
      mime: map["mime"],
      createdAt: DateTime.tryParse(map["created_at"].toString()),
      updatedAt: DateTime.tryParse(map["updated_at"].toString()),
      deletedAt: DateTime.tryParse(map["deleted_at"].toString()),
    );
  }

  static Map<String, dynamic> modelToMap(File file) {
    return {
      "id": file.id,
      "name": file.name,
      "description": file.description,
      "path": file.path,
      "mime": file.mime,
      "created_at": file.createdAt,
      "updated_at": file.updatedAt,
      "deleted_at": file.deletedAt,
    };
  }

  Future<File> find(String id, {RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await findR(
        id,
        options: options.copyWithAdded(
          queryParameters: {},
        ),
      );
      return modelFromMap(response.data!["file"]);
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

  Future<File> create(
      {required String id,
      String? name,
      String? description,
      required MultipartFile file,
      String? mime,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await createR(
        options: options.copyWithAdded(data: {
          if (id != null) 'id': id,
          if (name != null) 'name': name,
          if (description != null) 'description': description,
          if (file != null) 'file': file,
          if (mime != null) 'mime': mime,
          if (createdAt != null) 'created_at': createdAt,
          if (updatedAt != null) 'updated_at': updatedAt,
          if (deletedAt != null) 'deleted_at': deletedAt,
        }),
      );
      return modelFromMap(response.data!["file"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<File> update(String id,
      {String? name,
      String? description,
      MultipartFile? file,
      String? mime,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await updateR(
        id,
        options: options.copyWithAdded(
          data: {
            if (name != null) 'name': name,
            if (description != null) 'description': description,
            if (file != null) 'file': file,
            if (mime != null) 'mime': mime,
            if (createdAt != null) 'created_at': createdAt,
            if (updatedAt != null) 'updated_at': updatedAt,
            if (deletedAt != null) 'deleted_at': deletedAt
          },
        ),
      );
      return modelFromMap(response.data!["file"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<PaginatedFile> list(
      {int? page = 1,
      int? limit = 24,
      FileSortables? sort,
      SortOrder? order,
      String? search,
      FileSearchables? searchIn,
      Map<FileFields, String>? where,
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
        // [where] is a map of [FileFields] and [String], it should convert to a map of [String] and [String].
        if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
      }));
      return PaginatedFile.fromMap(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }
}

/// FileListOptions
class FileListOptions extends RequestOptions {
  FileListOptions(
      {int? page = 1,
      int? limit = 24,
      FileSortables? sort,
      SortOrder? order,
      String? search,
      FileSearchables? searchIn,
      Map<FileFields, String>? where,
      Map<String, dynamic>? queryParameters,
      super.cancelToken,
      super.data,
      super.onReceiveProgress,
      super.onSendProgress,
      super.options})
      : super(queryParameters: {
          ...?queryParameters,
          if (page != null) 'page': page.toString(),
          if (limit != null) 'limit': limit.toString(),
          if (sort != null) 'sort': sort.name,
          if (order != null) 'order': order.name,
          if (search != null) 'search': search,
          if (searchIn != null) 'searchIn': searchIn.name,
          // [where] is a map of [FileFields] and [String], it should convert to a map of [String] and [String].
          if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
        });
}

/// FileFindOptions
class FileFindOptions extends RequestOptions {
  FileFindOptions(
      {Map<String, dynamic>? queryParameters,
      super.cancelToken,
      super.data,
      super.onReceiveProgress,
      super.onSendProgress,
      super.options})
      : super(queryParameters: {
          ...?queryParameters,
        });
}

/// FileRelations
// no relations
/// FileFilterables
enum FileFilterables {
  name,
  description,
  path,
  mime,
  createdAt,
  updatedAt,
  deletedAt
}

/// FileSortables
enum FileSortables {
  name,
  description,
  path,
  mime,
  createdAt,
  updatedAt,
  deletedAt
}

/// FileSearchables
enum FileSearchables {
  name,
  description,
  path,
  mime,
  createdAt,
  updatedAt,
  deletedAt
}

/// FileFields
enum FileFields {
  id,
  name,
  description,
  path,
  mime,
  createdAt,
  updatedAt,
  deletedAt
}

/// FileTranslatables
// no fields
/// FileAuthCredentials
// no fields
/// PaginatedFile
class PaginatedFile extends PaginatedModel<File> {
  PaginatedFile({required this.data, required this.meta});

  final List<File> data;

  final PaginationMeta meta;

  static PaginatedFile fromMap(Map<String, dynamic> map) {
    return PaginatedFile(
      data: List<File>.from(map['data'].map((x) => File.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }
}

/// FileExtentions
extension FileExtensions on File {}

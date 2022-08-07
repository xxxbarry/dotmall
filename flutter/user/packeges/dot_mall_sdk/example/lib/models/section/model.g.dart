// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TableAnnotationGenerator
// **************************************************************************

// Sections
class Sections extends Collection<Section> {
  Sections(this.manager);

  final Manager manager;

  final String table = "sections";

  final String scope = "sections";

  static Section modelFromMap(Map<String, dynamic> map) {
    return Section(
      id: map["id"],
      name: map["name"],
      description: map["description"],
      slug: map["slug"],
      storeId: map["store_id"],
      photos: [
        for (var item in map["photos"] ?? []) Files.modelFromMap(item),
      ],
      translations: [
        for (var item in map["translations"] ?? [])
          SectionTranslations.modelFromMap(item),
      ],
    );
  }

  static Map<String, dynamic> modelToMap(Section section) {
    return {
      "id": section.id,
      "name": section.name,
      "description": section.description,
      "slug": section.slug,
      "store_id": section.storeId,
      "photos": section.photos.map((item) => item.toMap()).toList(),
      "translations": section.translations.map((item) => item.toMap()).toList(),
    };
  }

  Future<Section> find(String id,
      {List<SectionRelations>? load, RequestOptions? options}) async {
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
      return modelFromMap(response.data!["section"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<void> delete(String id,
      {List<SectionRelations>? load, RequestOptions? options}) async {
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

  Future<Section> create(
      {required String name,
      String? description,
      String? slug,
      required String storeId,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await createR(
        options: options.copyWithAdded(data: {
          if (name != null) 'name': name,
          if (description != null) 'description': description,
          if (slug != null) 'slug': slug,
          if (storeId != null) 'store_id': storeId,
        }),
      );
      return modelFromMap(response.data!["section"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<Section> update(String id,
      {String? name,
      String? description,
      String? slug,
      String? storeId,
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
            if (storeId != null) 'store_id': storeId
          },
        ),
      );
      return modelFromMap(response.data!["section"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<PaginatedSection> list(
      {List<SectionRelations>? load,
      int? page = 1,
      int? limit = 24,
      SectionSortables? sort,
      SortOrder? order,
      String? search,
      SectionSearchables? searchIn,
      Map<SectionFields, String>? where,
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
        // [where] is a map of [SectionFields] and [String], it should convert to a map of [String] and [String].
        if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
        if (load != null) 'load': load.map((e) => e.name).toList()
      }));
      return PaginatedSection.fromMap(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Files photos({RequestOptions? options}) {
    return Files(manager);
  }

  SectionTranslations translations({RequestOptions? options}) {
    return SectionTranslations(manager);
  }
}

// SectionRelations
enum SectionRelations { photos, translations }

// SectionFilterables
enum SectionFilterables { id, name, description, slug, storeId }

// SectionSortables
enum SectionSortables { id, name, description, slug, storeId }

// SectionSearchables
enum SectionSearchables { id, name, description, slug, storeId }

// SectionFields
enum SectionFields { id, name, description, slug, storeId }

// SectionTranslatables
// no fields
// SectionAuthCredentials
// no fields
// PaginatedSection
class PaginatedSection extends PaginatedModel {
  PaginatedSection({required this.data, required this.meta});

  final List<Section> data;

  final PaginationMeta meta;

  static PaginatedSection fromMap(Map<String, dynamic> map) {
    return PaginatedSection(
      data: List<Section>.from(map['data'].map((x) => Section.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TableAnnotationGenerator
// **************************************************************************

// SectionTranslations
class SectionTranslations extends Collection<SectionTranslation> {
  SectionTranslations(this.manager);

  final Manager manager;

  final String table = "section_translations";

  final String scope = "section_translations";

  static SectionTranslation modelFromMap(Map<String, dynamic> map) {
    return SectionTranslation(
      id: map["id"],
      locale: Languages.values.firstWhere((e) => e.name == map["locale"]),
      name: map["name"],
      description: map["description"],
      sectionId: map["section_id"],
    );
  }

  static Map<String, dynamic> modelToMap(
      SectionTranslation sectiontranslation) {
    return {
      "id": sectiontranslation.id,
      "locale": sectiontranslation.locale.name,
      "locale": sectiontranslation.locale.index,
      "name": sectiontranslation.name,
      "description": sectiontranslation.description,
      "section_id": sectiontranslation.sectionId,
    };
  }

  Future<SectionTranslation> find(String id, {RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await findR(
        id,
        options: options.copyWithAdded(
          queryParameters: {},
        ),
      );
      return modelFromMap(response.data!["section_translation"]);
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

  Future<SectionTranslation> create(
      {required Languages locale,
      required String name,
      String? description,
      required String sectionId,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await createR(
        options: options.copyWithAdded(data: {
          if (locale != null) 'locale': locale.name,
          if (name != null) 'name': name,
          if (description != null) 'description': description,
          if (sectionId != null) 'section_id': sectionId,
        }),
      );
      return modelFromMap(response.data!["section_translation"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<SectionTranslation> update(String id,
      {Languages? locale,
      String? name,
      String? description,
      String? sectionId,
      RequestOptions? options}) async {
    try {
      options = options ?? RequestOptions();
      var response = await updateR(
        id,
        options: options.copyWithAdded(
          data: {
            if (locale != null) 'locale': locale.name,
            if (name != null) 'name': name,
            if (description != null) 'description': description,
            if (sectionId != null) 'section_id': sectionId
          },
        ),
      );
      return modelFromMap(response.data!["section_translation"]);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }

  Future<PaginatedSectionTranslation> list(
      {int? page = 1,
      int? limit = 24,
      SectionTranslationSortables? sort,
      SortOrder? order,
      String? search,
      SectionTranslationSearchables? searchIn,
      Map<SectionTranslationFields, String>? where,
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
        // [where] is a map of [SectionTranslationFields] and [String], it should convert to a map of [String] and [String].
        if (where != null) 'where': where.map((k, v) => MapEntry(k.name, v)),
      }));
      return PaginatedSectionTranslation.fromMap(response.data!);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422 && e.response != null) {
        throw ValidationException.fromMap(e.response?.data);
      } else {
        rethrow;
      }
    }
  }
}

// SectionTranslationRelations
// no relations
// SectionTranslationFilterables
enum SectionTranslationFilterables { id, locale, name, description, sectionId }

// SectionTranslationSortables
enum SectionTranslationSortables { id, locale, name, description, sectionId }

// SectionTranslationSearchables
enum SectionTranslationSearchables { id, locale, name, description, sectionId }

// SectionTranslationFields
enum SectionTranslationFields { id, locale, name, description, sectionId }

// SectionTranslationTranslatables
// no fields
// SectionTranslationAuthCredentials
// no fields
// PaginatedSectionTranslation
class PaginatedSectionTranslation extends PaginatedModel {
  PaginatedSectionTranslation({required this.data, required this.meta});

  final List<SectionTranslation> data;

  final PaginationMeta meta;

  static PaginatedSectionTranslation fromMap(Map<String, dynamic> map) {
    return PaginatedSectionTranslation(
      data: List<SectionTranslation>.from(
          map['data'].map((x) => SectionTranslation.fromMap(x))),
      meta: PaginationMeta.fromMap(map['meta']),
    );
  }
}

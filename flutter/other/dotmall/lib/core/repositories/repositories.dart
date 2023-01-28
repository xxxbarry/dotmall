// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import 'package:dotmall_sdk/dotmall_sdk.dart';

class AppRepository {
  Configs configs;
  AppRepository(this.configs);

  Manager get manager => Manager(configs);
}

/// [CachRepository]
abstract class CachRepository {
  Future<void> clear();
}

/// [CachePaginatedModel]
class CachePaginatedModel<T extends Model> {
  /// init the cache repository
  Future<void> init() async {
    await Hive.openBox<T>(T.runtimeType.toString());
  }

  Future<void> load() async {
    // requests = await Hive.openBox<T>(T.runtimeType.toString());
  }

  Future<void> add(PaginatedModel<T> response) async {
    _responses[DateTime.now()] = response;
  }

  Map<DateTime, PaginatedModel<T>> _responses = {};

  Map<DateTime, PaginatedModel<T>> get responses => _responses;

  // getter to get all categories from requests
  List<T> get models {
    var models = <T>[];
    for (var response in _responses.values) {
      models.addAll(response.data);
    }
    return models;
  }

  Future<void> clear() async {
    _responses = {};
    var box = await Hive.openBox<T>(T.runtimeType.toString());
    await box.clear();
  }
}

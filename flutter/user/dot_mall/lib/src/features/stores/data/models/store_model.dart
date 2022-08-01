import 'dart:convert';

import '../../domain/entities/store.dart';

class StoreModel extends Store {
  StoreModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.status});
}

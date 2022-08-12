import 'dart:convert';

import 'dart:convert';
import 'package:auto_sdk_annotations/auto_sdk_annotations.dart';
import 'package:dio/dio.dart' show DioError, MultipartFile;
import 'package:auto_sdk_core/auto_sdk_core.dart';

part 'model.g.dart';

@Table()
class File extends Model {
  @Column(primary: true, searchable: false, sortable: false, filterable: false)
  final String id;
  @Column()
  final String? name;
  @Column()
  final String? description;
  @Column(required: true, behavior: "file", behaviorAs: 'file')
  final String path;

  @Column()
  final String? mime;
  @Column()
  final DateTime? createdAt;
  @Column()
  final DateTime? updatedAt;
  @Column()
  final DateTime? deletedAt;
  File({
    required this.id,
    required this.name,
    required this.path,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.mime,
    this.deletedAt,
  });

  factory File.fromMap(Map<String, dynamic> map) => Files.modelFromMap(map);
  Map<String, dynamic> toMap() => Files.modelToMap(this);
}

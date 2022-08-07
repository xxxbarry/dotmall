import 'dart:convert';

import '../model.dart';

class File extends Model with TimestampMixin, DeletedAtMixin, RelatedMixin {
  final String id;
  final String? name;
  final String? description;
  final String path;
  final String? mime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  File({
    required this.id,
    this.name,
    this.description,
    required this.path,
    this.mime,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  File copyWith({
    String? id,
    String? name,
    String? description,
    String? path,
    String? mime,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return File(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      path: path ?? this.path,
      mime: mime ?? this.mime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'path': path,
      'mime': mime,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }

  factory File.fromMap(Map<String, dynamic> map) {
    return File(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      path: map['path'],
      mime: map['mime'],
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt']).toLocal()
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt']).toLocal()
          : null,
      deletedAt: map['deletedAt'] != null
          ? DateTime.parse(map['deletedAt']).toLocal()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory File.fromJson(String source) => File.fromMap(json.decode(source));

  @override
  String toString() {
    return 'File(id: $id, name: $name, description: $description, path: $path, mime: $mime, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is File &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.path == path &&
        other.mime == mime &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deletedAt == deletedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        path.hashCode ^
        mime.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deletedAt.hashCode;
  }
}

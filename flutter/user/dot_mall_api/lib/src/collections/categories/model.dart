import 'dart:convert';

import '../files/model.dart';
import '../model.dart';

class Category extends Model {
  final String id;
  final String name;
  final String? description;
  final List<File>? photos;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  Category({
    required this.id,
    required this.name,
    this.description,
    this.photos,
    this.createdAt,
    this.updatedAt,
  });

  Category copyWith({
    String? id,
    String? name,
    String? description,
    List<File>? photos,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      photos: photos ?? this.photos,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'photos': photos?.map((x) => x.toMap()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      description: map['description'] != null ? map['description'] : null,
      photos: map['photos'] != null
          ? List<File>.from(map['photos'].map((x) => File.fromMap(x)))
          : null,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt']).toLocal()
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt']).toLocal()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Category(id: $id, name: $name, description: $description, photos: $photos, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        photos.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

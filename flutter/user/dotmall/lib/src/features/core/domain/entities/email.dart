// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Email {
  final String id;
  final String? value;
  final DateTime? validatedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String? relatedId;
  final String? relatedType;

  const Email({
    required this.id,
    this.value,
    this.validatedAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.relatedId,
    this.relatedType,
  });

  Email copyWith({
    String? id,
    String? value,
    DateTime? validatedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? relatedId,
    String? relatedType,
  }) {
    return Email(
      id: id ?? this.id,
      value: value ?? this.value,
      validatedAt: validatedAt ?? this.validatedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      relatedId: relatedId ?? this.relatedId,
      relatedType: relatedType ?? this.relatedType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'validatedAt': validatedAt?.millisecondsSinceEpoch,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'deletedAt': deletedAt?.millisecondsSinceEpoch,
      'relatedId': relatedId,
      'relatedType': relatedType,
    };
  }

  factory Email.fromMap(Map<String, dynamic> map) {
    return Email(
      id: map['id'] as String,
      value: map['value'] != null ? map['value'] as String : null,
      validatedAt: map['validatedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['validatedAt'] as int) : null,
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int) : null,
      deletedAt: map['deletedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['deletedAt'] as int) : null,
      relatedId: map['relatedId'] != null ? map['relatedId'] as String : null,
      relatedType: map['relatedType'] != null ? map['relatedType'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Email.fromJson(String source) => Email.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Email(id: $id, value: $value, validatedAt: $validatedAt, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, relatedId: $relatedId, relatedType: $relatedType)';
  }

  @override
  bool operator ==(covariant Email other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.value == value &&
      other.validatedAt == validatedAt &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.deletedAt == deletedAt &&
      other.relatedId == relatedId &&
      other.relatedType == relatedType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      value.hashCode ^
      validatedAt.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      deletedAt.hashCode ^
      relatedId.hashCode ^
      relatedType.hashCode;
  }
}

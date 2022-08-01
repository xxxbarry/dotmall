// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:dot_mall/src/features/core/domain/entities/address.dart';
import 'package:dot_mall/src/features/core/domain/entities/phone.dart';

import '../../../core/domain/entities/image.dart';

/// store status enum
enum StoreStatus {
  panding,
  active,
  inactive,
  suspended,
}

/// store model class
class Store {
  final String id;
  final String name;
  final String description;
  final StoreStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final DateTime? validatedAt;
  final Address? address;
  final Phone? phone;
  final Image? photo;
  final String? relatedId;
  final String? relatedType;
  const Store({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.validatedAt,
    this.address,
    this.phone,
    this.photo,
    this.relatedId,
    this.relatedType,
  });
}

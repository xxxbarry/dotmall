import 'package:annotations/annotations.dart';
import 'package:dot_mall_sdk/src/base.dart';

/// [Model]
class Model {
  Model();
  //fromJson
  factory Model.fromJson(Map<String, dynamic> json) => Model();
  // toMap
  Map<String, dynamic> toMap() => <String, dynamic>{};
  factory Model.fromMap(Map<String, dynamic> map) => Model();
}

/// [ModelTranslation]
class ModelTranslation extends Model {
  @Column()
  final Languages locale;

  ModelTranslation({required this.locale});
}

/// [TimestampMixin] is a mixin that provides timestamp for the [Model].
mixin TimestampMixin {
  DateTime? createdAt;
  DateTime? updatedAt;
}

/// [deleted_at] is a mixin that provides deleted_at for the [Model].
mixin DeletedAtMixin {
  DateTime? deletedAt;
}

/// [ValidatedAtMixin] is a mixin that provides validated_at for the [Model].
mixin ValidatedAtMixin {
  DateTime? validatedAt;
}

/// [RelatedMixin] is a mixin that provides related_id & related_type for the [Model].
mixin RelatedMixin {
  String? relatedId;
  String? relatedType;
}

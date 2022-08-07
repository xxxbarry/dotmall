import 'file.dart';

class Image extends File {
  const Image({
    required super.id,
    super.name,
    super.description,
    super.path,
    super.mime,
    super.createdAt,
    super.updatedAt,
    super.relatedId,
    super.relatedType,
  });
}

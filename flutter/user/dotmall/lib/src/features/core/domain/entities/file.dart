// export default class File extends DotBaseModel {

//   @column({ isPrimary: true })
//   public id: string

//   @column()
//   public name: string|null

//   @column()
//   public description: string|null

//   @column()
//   public path: string|null

//   @column()
//   public mime: string|null

//   @column.dateTime({ autoCreate: true })
//   public createdAt: DateTime

//   @column.dateTime({ autoCreate: true, autoUpdate: true })
//   public updatedAt: DateTime

//   @column({ serializeAs: null })
//   public relatedId: string

//   @column({ serializeAs: null })
//   public relatedType: string
// }
import 'package:equatable/equatable.dart';

class File {
  final String id;
  final String? name;
  final String? description;
  final String? path;
  final String? mime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? relatedId;
  final String? relatedType;

  const File({
    required this.id,
    this.name,
    this.description,
    this.path,
    this.mime,
    this.createdAt,
    this.updatedAt,
    this.relatedId,
    this.relatedType,
  });
}

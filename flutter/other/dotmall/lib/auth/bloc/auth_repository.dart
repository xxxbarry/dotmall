// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotmall_sdk/dotmall_sdk.dart';

class AuthRepository<T extends AuthCollection> {
  final T collection;

  AuthRepository({
    required this.collection,
  });
}

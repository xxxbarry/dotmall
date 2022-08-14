import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:hive/hive.dart';

import '../../core/repositories/repositories.dart';

/// [AuthCacheRepository]
class AuthCacheRepository implements CachRepository {
  @override
  Future<void> clear() {
    throw UnimplementedError();
  }

  // readToken() {}
  Future<Token?> readToken() async {
    Box box = await Hive.openBox('auth');
    var _tokenJson = box.get('token');
    return _tokenJson != null ? Token.fromJson(_tokenJson) : null;
  }
}

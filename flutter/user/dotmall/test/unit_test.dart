// This is an example unit test.
//
// A unit test tests a single function, method, or class. To learn more about
// writing unit tests, visit
// https://flutter.dev/docs/cookbook/testing/unit/introduction

import 'package:flutter_test/flutter_test.dart';
import 'package:dotmall_sdk/dotmall_sdk.dart';

void main() {
  group('Plus Operator', () {
    test('should add two numbers together', () {
      expect(1 + 1, 2);
    });
  });

  // Test the `Manager` class.
  test('test', () async {
    var configs = Configs();
    var manager = Manager(configs);

    // signup
    var credentials = const UserAuthCredentials(
      username: '213375656915',
      password: 'admin',
    );
    var response = await Users(manager).signin(credentials);
    expect(response.model.phones.first.value, credentials.username);
  });
}

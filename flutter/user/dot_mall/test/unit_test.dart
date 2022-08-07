// This is an example unit test.
//
// A unit test tests a single function, method, or class. To learn more about
// writing unit tests, visit
// https://flutter.dev/docs/cookbook/testing/unit/introduction

import 'package:dot_mall/src/features/core/dot_mall_sdk/dot_mall_sdk.dart'
    as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Plus Operator', () {
    test('should add two numbers together', () {
      expect(1 + 1, 2);
    });
  });

  // Test the `Manager` class.
  test('should initialize the manager', () async {
    var manager = api.Manager(
      configs: api.Configs(prodEndpoint: ""),
    );
    manager.init();
    var data = await manager.categories.find("id");
    print(data);
  });
}

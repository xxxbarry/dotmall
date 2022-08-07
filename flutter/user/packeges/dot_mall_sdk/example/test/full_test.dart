import 'package:dot_mall_sdk/dot_mall_sdk.dart';
import 'package:example/models/account/model.dart';
import 'package:example/models/category/model.dart';
import 'package:example/models/category_translation/model.dart';
import 'package:example/models/customer_profile/model.dart';
import 'package:example/models/merchant_profiles/model.dart';
import 'package:example/models/user/model.dart';
import 'package:test/test.dart';

void main() {
  var configs = Configs(auth: Users.new);
  var manager = Manager(configs);
  // user signup
  var userCredentials = const UserAuthCredentials(
    username: "213657606332",
    password: "password",
  );
  User? user;
  Token? token;
  group('User', () {
    test('signup', () async {
      try {
        var response =
            await Users(manager).signup(credentials: userCredentials);
        user = response.model;
        token = response.token;
        manager.token = token;
        expect(user, isNotNull);
        expect(token, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('signin', () async {
      try {
        var response =
            await Users(manager).signin(credentials: userCredentials);
        user = response.model;
        token = response.token;
        manager.token = token;
        expect(user, isNotNull);
        expect(token, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('auth', () async {
      try {
        var user = await Users(manager).auth();
        expect(user, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });

    // list users
    var users = <User>[];
    test('list', () async {
      try {
        var response = await Users(manager).list();
        users = response.data;
        expect(response.data, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });

    // find user
    test('find', () async {
      try {
        var user = await Users(manager).find(users.first.id);
        expect(user, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      } catch (e) {
        rethrow;
      }
    });

    // update user
    test('update', () async {
      try {
        var user = await Users(manager).update(
          users.first.id,
        );
        expect(user, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });

    // create user
    User? tempUser;
    test('create', () async {
      try {
        tempUser = await Users(manager).create(password: "password");
        expect(user, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });

    // delete user
    test('delete', () async {
      try {
        await Users(manager).delete(
          tempUser!.id,
        );
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });

    // test('signout', () async {
    //   try {
    //     await Users(manager).signout();
    //     user = null;
    //     token = null;
    //   } on ValidationException catch (e) {
    //     expect(e.errors, isNotNull);    rethrow;

    //   }
    // });
  });

  // Category group
  var categories = <Category>[];
  Category? category;
  group('Category', () {
    test('create', () async {
      try {
        category = await Categories(manager).create(
          name: "test",
          description: "tests",
        );
        expect(category!.id, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('list', () async {
      try {
        var response = await Categories(manager).list();
        categories = response.data;
        expect(response.data, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('find', () async {
      try {
        var category = await Categories(manager).find(categories.first.id);
        expect(category, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('update', () async {
      try {
        var category = await Categories(manager).update(
          categories.first.id,
        );
        expect(category, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('delete', () async {
      try {
        await Categories(manager).delete(
          categories.first.id,
        );
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
  });

  // CategoryTranslation group
  var categoryTranslations = <CategoryTranslation>[];
  CategoryTranslation? categoryTranslation;
  group('CategoryTranslation', () {
    test('create', () async {
      try {
        categoryTranslation = await CategoryTranslations(manager).create(
          categoryId: categories.first.id,
          locale: Languages.ar,
          name: "test",
          description: "tests",
        );
        expect(categoryTranslation!.id, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('list', () async {
      try {
        var response = await CategoryTranslations(manager).list();
        categoryTranslations = response.data;
        expect(response.data, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('find', () async {
      try {
        var categoryTranslation = await CategoryTranslations(manager).find(
          categoryTranslations.first.id,
        );
        expect(categoryTranslation, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('update', () async {
      try {
        var categoryTranslation = await CategoryTranslations(manager).update(
          categoryTranslations.first.id,
          name: "updated",
          description: "updated",
        );
        expect(categoryTranslation, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('delete', () async {
      try {
        await CategoryTranslations(manager).delete(
          categoryTranslations.first.id,
        );
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
  });

  // Account group
  var accounts = <Account>[];
  Account? account;
  group('Account', () {
    test('create', () async {
      try {
        account = await Accounts(manager).create(
          userId: user!.id,
          name: "test",
          description: "tests",
          type: AccountType.business,
        );
        expect(account!.id, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('list', () async {
      try {
        var response = await Accounts(manager).list();
        accounts = response.data;
        expect(response.data, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('find', () async {
      try {
        account = await Accounts(manager).find(account!.id);
        expect(account, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('update', () async {
      try {
        account = await Accounts(manager).update(
          account!.id,
          name: "updated",
          description: "updated",
          type: AccountType.personal,
        );
        expect(account, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      } catch (e) {
        rethrow;
      }
    });
    test('delete', () async {
      try {
        await Accounts(manager).delete(
          account!.id,
        );
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
  });

  // CustomerProfile group
  // has only accountId
  var customerProfiles = <CustomerProfile>[];
  CustomerProfile? customerProfile;
  group('CustomerProfile', () {
    test('create', () async {
      try {
        customerProfile = await CustomerProfiles(manager).create(
          accountId: account!.id,
        );
        expect(customerProfile!.id, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('list', () async {
      try {
        var response = await CustomerProfiles(manager).list();
        customerProfiles = response.data;
        expect(response.data, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('find', () async {
      try {
        customerProfile = await CustomerProfiles(manager).find(
          customerProfile!.id,
        );
        expect(customerProfile, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('update', () async {
      try {
        customerProfile = await CustomerProfiles(manager).update(
          customerProfile!.id,
        );
        expect(customerProfile, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('delete', () async {
      try {
        await CustomerProfiles(manager).delete(
          customerProfile!.id,
        );
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
  });
}

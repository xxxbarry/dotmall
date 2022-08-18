import 'package:auto_sdk_core/auto_sdk_core.dart';
import 'package:dotmall_sdk/dotmall_sdk.dart';
import 'package:dotmall_sdk/src/order/model.dart';
import 'package:test/test.dart';

void main() {
  var configs = Configs(auth: Users.new);
  var manager = Manager(configs);
  // user signup
  var userCredentials = const UserAuthCredentials(
    username: "213657606342",
    password: "password",
  );
  User? user;
  Token? token;
  group('User', () {
    test('signup', () async {
      try {
        var response = await Users(manager).signup(userCredentials);
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
        var response = await Users(manager).signin(userCredentials);
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

  // MerchantProfile group
  // has only accountId
  var merchantProfiles = <MerchantProfile>[];
  MerchantProfile? merchantProfile;
  group('MerchantProfile', () {
    test('create', () async {
      try {
        merchantProfile = await MerchantProfiles(manager).create(
          accountId: account!.id,
        );
        expect(merchantProfile!.id, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('list', () async {
      try {
        var response = await MerchantProfiles(manager).list();
        merchantProfiles = response.data;
        expect(response.data, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('find', () async {
      try {
        merchantProfile = await MerchantProfiles(manager).find(
          merchantProfile!.id,
        );
        expect(merchantProfile, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('update', () async {
      try {
        merchantProfile = await MerchantProfiles(manager).update(
          merchantProfile!.id,
        );
        expect(merchantProfile, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('delete', () async {
      try {
        await MerchantProfiles(manager).delete(
          merchantProfile!.id,
        );
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
  });

  // Store group
  var stores = <Store>[];
  Store? store;
  group('Store', () {
    test('create', () async {
      try {
        store = await Stores(manager).create(
          merchantProfileId: merchantProfile!.id,
          name: "test",
          description: "tests",
        );
        expect(store!.id, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('list', () async {
      try {
        var response = await Stores(manager).list();
        stores = response.data;
        expect(response.data, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('find', () async {
      try {
        store = await Stores(manager).find(store!.id);
        expect(store, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('update', () async {
      try {
        store = await Stores(manager).update(
          store!.id,
          name: "updated",
          description: "updated",
        );
        expect(store, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('delete', () async {
      try {
        await Stores(manager).delete(
          store!.id,
        );
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
  });

  // StoreTranslation group
  // only name and description
  var storeTranslations = <StoreTranslation>[];
  StoreTranslation? storeTranslation;
  group('StoreTranslation', () {
    test('create', () async {
      try {
        storeTranslation = await StoreTranslations(manager).create(
          locale: Languages.en,
          storeId: store!.id,
          name: "test",
          description: "tests",
        );
        expect(storeTranslation!.id, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('list', () async {
      try {
        var response = await StoreTranslations(manager).list();
        storeTranslations = response.data;
        expect(response.data, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('find', () async {
      try {
        storeTranslation = await StoreTranslations(manager).find(
          storeTranslation!.id,
        );
        expect(storeTranslation, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('update', () async {
      try {
        storeTranslation = await StoreTranslations(manager).update(
          storeTranslation!.id,
          name: "updated",
          description: "updated",
        );
        expect(storeTranslation, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('delete', () async {
      try {
        await StoreTranslations(manager).delete(
          storeTranslation!.id,
        );
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
  });

  // Section group
  // Section is just like Category but has storeId
  var sections = <Section>[];
  Section? section;
  group('Section', () {
    test('create', () async {
      try {
        section = await Sections(manager).create(
          storeId: store!.id,
          name: "test",
          description: "tests",
        );
        expect(section!.id, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('list', () async {
      try {
        var response = await Sections(manager).list();
        sections = response.data;
        expect(response.data, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('find', () async {
      try {
        section = await Sections(manager).find(section!.id);
        expect(section, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('update', () async {
      try {
        section = await Sections(manager).update(
          section!.id,
          name: "updated",
          description: "updated",
        );
        expect(section, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('delete', () async {
      try {
        await Sections(manager).delete(
          section!.id,
        );
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
  });

  // SectionTranslation group
  // only name and description and locale and sectionId and slug
  var sectionTranslations = <SectionTranslation>[];
  SectionTranslation? sectionTranslation;
  group('SectionTranslation', () {
    test('create', () async {
      try {
        sectionTranslation = await SectionTranslations(manager).create(
          locale: Languages.en,
          sectionId: section!.id,
          name: "test",
          description: "tests",
        );
        expect(sectionTranslation!.id, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('list', () async {
      try {
        var response = await SectionTranslations(manager).list();
        sectionTranslations = response.data;
        expect(response.data, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('find', () async {
      try {
        sectionTranslation = await SectionTranslations(manager).find(
          sectionTranslation!.id,
        );
        expect(sectionTranslation, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('update', () async {
      try {
        sectionTranslation = await SectionTranslations(manager).update(
          sectionTranslation!.id,
          name: "updated",
          description: "updated",
        );
        expect(sectionTranslation, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('delete', () async {
      try {
        await SectionTranslations(manager).delete(
          sectionTranslation!.id,
        );
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
  });

  // Addresses group
  var addresses = <Address>[];
  Address? address;
  group('Address', () {
    test('create', () async {
      try {
        address = await Addresses(manager).create(
          userId: user!.id,
          primary: "test",
          secondary: "tests",
          city: "test",
          state: "tests",
          zip: "test",
          country: "test",
          latitude: 1,
          longitude: 1,
        );
        expect(address!.id, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('list', () async {
      try {
        var response = await Addresses(manager).list();
        addresses = response.data;
        expect(response.data, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('find', () async {
      try {
        address = await Addresses(manager).find(address!.id);
        expect(address, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('update', () async {
      try {
        address = await Addresses(manager).update(
          address!.id,
          secondary: "updated",
          city: "updated",
          state: "updated",
          zip: "updated",
          country: "updated",
          latitude: 35.64654,
          longitude: 30.15367,
        );
        expect(address, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('delete', () async {
      try {
        await Addresses(manager).delete(
          address!.id,
        );
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
  });

  // Order group
  // order has customerProfileId(customerProfile.id) and addressId and status and of course timestamp(createdAt)
  var orders = <Order>[];
  Order? order;
  group('Order', () {
    test('create', () async {
      try {
        order = await Orders(manager).create(
          customerProfileId: customerProfile!.id,
          addressId: address!.id,
          status: OrderStatus.pending,
        );
        expect(order!.id, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('list', () async {
      try {
        var response = await Orders(manager).list();
        orders = response.data;
        expect(response.data, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('find', () async {
      try {
        order = await Orders(manager).find(order!.id);
        expect(order, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('update', () async {
      try {
        order = await Orders(manager).update(
          order!.id,
          status: OrderStatus.pending,
        );
        expect(order, isNotNull);
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
    test('delete', () async {
      try {
        await Orders(manager).delete(
          order!.id,
        );
      } on ValidationException catch (e) {
        expect(e.errors, isNotNull);
        rethrow;
      }
    });
  });
}

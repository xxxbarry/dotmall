import BaseSeeder from '@ioc:Adonis/Lucid/Seeder'
import faker from '@faker-js/faker'
import Hash from '@ioc:Adonis/Core/Hash'
import Email from 'App/Models/ContactOptions/Email'
import DotBaseModel from 'Dot/models/DotBaseModel'
import User, { AuthPivotTags } from 'App/Models/User'
import Phone from 'App/Models/ContactOptions/Phone'
import Account, { AccountType } from 'App/Models/Account'
import { BusinessAccountData } from 'App/Models/accounts/business/BusinessAccountData'
import CustomerProfile from 'App/Models/accounts/profiles/CustomerProfile'
import Category from 'App/Models/Category'
import CategoryTranslation from 'App/Models/translations/CategoryTranslation'
import Store, { StoreStatus } from 'App/Models/accounts/business/stores/Store'
import Section from 'App/Models/accounts/business/stores/Section'
import StoreTranslation from 'App/Models/translations/StoreTranslation'
import SectionTranslation from 'App/Models/translations/SectionTranslation'
import Product, { ProductStatus, ProductType } from 'App/Models/accounts/business/stores/Product'
import ProductTranslation from 'App/Models/translations/ProductTranslation'
import File, { Image } from 'App/Models/File'

export default class UserSeeder extends BaseSeeder {
  public async run() {
    var users: any = []
    var emails: any = []
    var phones: any = []
    var accounts: any = []
    var customers: any = []
    var merchants: any = []
    var categories: any = []
    var categoryTranslations: any = []
    var stores: any = []
    var storeTranslations: any = []
    var sections: any = []
    var sectionTranslations: any = []
    var products: any = []
    var productTranslations: any = []
    var files: any = []

    for (let i = 0; i < 10; i++) {
      // create user
      let user = await User.create({
        password: await Hash.make('password'),
      })
      users.push(user)

      var userFiles: any = []
      // create images
      for (let i = 0; i < 10; i++) {
        userFiles.push(
          await Image.create({
            name: faker.lorem.words(2),
            path: faker.image.imageUrl(),
            userId: user!.id,
          })
        )
      }
      files = {
        ...files,
        ...userFiles,
      }

      // create email
      let email = await Email.create({
        value: faker.internet.email(),
        userId: user.id,
      })
      // attach email to user
      await user.related('phones').attach({
        [email.id]: {
          id: DotBaseModel.generateId(),
          tag: AuthPivotTags.user,
        },
      })

      // create phone
      let phone = await Phone.create({
        value: faker.phone.phoneNumber('213#########'),
        userId: user.id,
      })
      phones.push(phone)
      // attach phone to user
      await user.related('phones').attach({
        [phone.id]: {
          id: DotBaseModel.generateId(),
          tag: AuthPivotTags.user,
        },
      })

      // create account
      let account = await Account.create({
        userId: user.id,
        name: faker.name.findName(),
        description: faker.lorem.paragraph(),
        type: faker.random.arrayElement(Object.values(AccountType)) as AccountType,
        data: {
          name: faker.name.findName(),
          fullname: faker.name.findName(),
          age: 20,
        },
      })
      accounts.push(account)

      // create customer
      let customer = await CustomerProfile.create({
        accountId: account.id,
      })
      customers.push(customer)

      // create merchant
      let merchant = await CustomerProfile.create({
        accountId: account.id,
      })
      merchants.push(merchant)

      // create category
      let category = await Category.create({
        // category name
        name: faker.commerce.department(),
        description: faker.lorem.paragraph(),
        slug: faker.commerce.department().toLowerCase(),
      })
      categories.push(category)
      // create category translation
      let categoryTranslation = await CategoryTranslation.create({
        locale: 'en',
        name: faker.commerce.department(),
        description: faker.lorem.paragraph(),
        categoryId: category.id,
      })
      categoryTranslations.push(categoryTranslation)

      // create store
      let store = await Store.create({
        merchantProfileId: merchant.id,
        name: faker.commerce.department(),
        description: faker.lorem.paragraph(),
        status: faker.random.arrayElement(Object.values(StoreStatus)) as StoreStatus,
      })
      stores.push(store)
      // create store translation
      let storeTranslation = await StoreTranslation.create({
        locale: 'en',
        name: faker.commerce.department(),
        description: faker.lorem.paragraph(),
        storeId: store.id,
      })
      storeTranslations.push(storeTranslation)

      // create section
      let section = await Section.create({
        storeId: store.id,
        name: faker.commerce.department(),
        description: faker.lorem.paragraph(),
        slug: faker.commerce.department().toLowerCase(),
      })
      sections.push(section)
      // create section translation
      let sectionTranslation = await SectionTranslation.create({
        locale: 'en',
        name: faker.commerce.department(),
        description: faker.lorem.paragraph(),
        sectionId: section.id,
      })
      sectionTranslations.push(sectionTranslation)

      // create product
      let product = await Product.create({
        sectionId: section.id,
        storeId: store.id,
        name: faker.commerce.productName(),
        description: faker.lorem.paragraph(),
        // barcode is string
        barcode: faker.random.word(),
        price: Number(faker.commerce.price()),
        quantity: faker.random.arrayElement([0, 1, 53, 4, 500, 96, 87, 858, 9, 10]),
        body: faker.lorem.paragraph(),
        slug: faker.commerce.productName().toLowerCase(),
        type: faker.random.arrayElement(Object.values(ProductType)) as ProductType,
        status: faker.random.arrayElement(Object.values(ProductStatus)) as ProductStatus,
        meta: {
          keywords: faker.lorem.words(),
        },
      })
      products.push(product)
      // create product translation
      let productTranslation = await ProductTranslation.create({
        locale: 'en',
        name: faker.commerce.productName(),
        description: faker.lorem.paragraph(),
        body: faker.lorem.paragraph(),
        productId: product.id,
        slug: faker.commerce.productName().toLowerCase(),
      })
      productTranslations.push(productTranslation)
    }
  }
}

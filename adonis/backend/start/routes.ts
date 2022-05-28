/*
|--------------------------------------------------------------------------
| Routes
|--------------------------------------------------------------------------
|
| This file is dedicated for defining HTTP routes. A single file is enough
| for majority of projects, however you can define routes in different
| files and just make sure to import them inside this file. For example
|
| Define routes in following two files
| ├── start/routes/cart.ts
| ├── start/routes/customer.ts
|
| and then import them inside `start/routes.ts` as follows
|
| import './routes/cart'
| import './routes/customer'
|
*/
import Route from '@ioc:Adonis/Core/Route'
import { AccountType } from 'App/Models/accounts/Account'
import { BusinessAccountData } from 'App/Models/accounts/business/BusinessAccountData'
import User from 'App/Models/User'
import './apis/apis'

Route.get('/c', "UsersController.signup")

Route.get('/', async () => {
  // return I18n.locale('en').formatMessage('validator.app.name')
  var user = await User.create({
    password: "mail@mail"
  })
  await user.related('emails').create({
    value: "mail@mail.mail",
    relatedType: "User",
  })
  await user.related('emails').create({
    value: "mail@mail2.mail",
    relatedType: "User",
  })
  await user.related('emails').create({
    value: "mail@mail3.mail",
    relatedType: "User",
  })
  await user.related('phones').create({
    value: "214657606315",
    relatedType: "User",
  });

  var account = await user.related('accounts').create({
    type: AccountType.business,
    name: "business account",
    data: new BusinessAccountData({
      name: "business account",
    }),
  });
  var customerProfile = await account.related("customer").create({
  });
  var merchantProfile = await account.related("merchant").create({
  });
  var address = await merchantProfile.related("address").create({
    city: "city",
    state: "state",
    country: "country",
    zip: "zip",
    primary: "sefez",
    secondary: "sefez",
  });
  var phones = await merchantProfile.related("phones").createMany([
    {
      value: "213657606315",
    },
    {
      value: "913657606315",
    },
  ]);
  var emails = await merchantProfile.related("emails").createMany([
    {
      value: "example@mail.mail",
    },
    {
      value: "hoem@mail.com",
    },
  ]);


  // Store
  var store = await merchantProfile.related("stores").create({
    name: "store",
    description: "description",
  });
  
  // await store.related("address").create({
  //   primary: "City 450 - Street 1",
  //   secondary: "Apartment 1, Floor 1",
  //   country: "Algeria",
  //   city: "Alger",
  //   state: "Alger",
  //   zip: "56333",
  // });
  // await store.related("phone").create({
  //   value: "213657606315",
  // });
  // await store.related("email").create({
  //   value: "example@mail.com",
  // });
  // await store.related("avatar").create({
  //   path: "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png",
  // });
  // var category0 = await store.related("categories").create({
  //   name: "category0",
  //   description: "description0",
  //   slug: "category",
  // });
  // var category = await store.related("categories").create({
  //   name: "category1",
  //   description: "description1",
  //   slug: "category1",
  //   categoryId: category0.id,
  // });

  // var product = await store.related("products").create({
  //   name: "product",
  //   description: "description",
  //   slug: "product",

  await user.load('accounts')
  await user.load('phones')
  await user.load('emails')
  return user
})

import Route from '@ioc:Adonis/Core/Route'

Route.resource('/stores', 'StoresController').except(
  ['edit', 'create']
).middleware({
  "store": "auth",
  "update": "auth",
  "destroy": "auth",
})

Route.resource('stores.translations', 'StoreTranslationsController').except(
  ['edit', 'create']
).middleware({
  "store": "auth",
  "update": "auth",
  "destroy": "auth",
})

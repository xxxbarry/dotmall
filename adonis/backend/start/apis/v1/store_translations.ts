import Route from '@ioc:Adonis/Core/Route'

Route.resource('store_translations', 'StoreTranslationsController').except(
  ['edit', 'create']
).middleware({
  "store": "auth",
  "update": "auth",
  "destroy": "auth",
})

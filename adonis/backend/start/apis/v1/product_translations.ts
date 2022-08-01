import Route from '@ioc:Adonis/Core/Route'

Route.resource('product_translations', 'ProductTranslationsController').except(
  ['edit', 'create']
).middleware({
  "store": "auth",
  "update": "auth",
  "destroy": "auth",
})

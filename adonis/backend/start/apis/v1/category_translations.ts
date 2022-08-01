import Route from '@ioc:Adonis/Core/Route'

Route.resource('category_translations', 'CategoryTranslationsController').except(
  ['edit', 'create']
).middleware({
  "store": "auth",
  "update": "auth",
  "destroy": "auth",
})

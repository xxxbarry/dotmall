import Route from '@ioc:Adonis/Core/Route'

Route.resource('section_translations', 'SectionTranslationsController').except(
  ['edit', 'create']
).middleware({
  "store": "auth",
  "update": "auth",
  "destroy": "auth",
})

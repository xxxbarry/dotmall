import Route from '@ioc:Adonis/Core/Route'

Route.resource('/sections', 'SectionsController').except(
    ['edit', 'create']
).middleware({
    "store": "auth",
    "update": "auth",
    "destroy": "auth",
})

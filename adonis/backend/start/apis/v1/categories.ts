import Route from '@ioc:Adonis/Core/Route'

Route.resource('/categories', 'CategoriesController').except(
    ['edit', 'create']
).middleware({
    "store": "auth",
    "update": "auth",
    "destroy": "auth",
})

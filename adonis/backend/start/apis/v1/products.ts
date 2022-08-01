import Route from '@ioc:Adonis/Core/Route'

Route.resource('/products', 'ProductsController').except(
    ['edit', 'create']
).middleware({
    "store": "auth",
    "update": "auth",
    "destroy": "auth",
})

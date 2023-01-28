import Route from '@ioc:Adonis/Core/Route'

Route.resource('/orders', 'OrdersController').except(
    ['edit', 'create']
).middleware({
    "store": "auth",
    "update": "auth",
    "destroy": "auth",
})

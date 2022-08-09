import Route from '@ioc:Adonis/Core/Route'

Route.resource('/order_items', 'OrderItemsController').except(
    ['edit', 'create']
).middleware({
    "store": "auth",
    "update": "auth",
    "destroy": "auth",
})

import Route from '@ioc:Adonis/Core/Route'

Route.resource('/addresses', 'AddressesController').except(
    ['edit', 'create']
).middleware({
    "store": "auth",
    "update": "auth",
    "destroy": "auth",
})

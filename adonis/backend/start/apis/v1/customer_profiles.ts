import Route from '@ioc:Adonis/Core/Route'

Route.resource('/customer_profiles', 'CustomerProfilesController').except(
    ['edit', 'create']
).middleware({
    "*": "auth",
})

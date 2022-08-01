import Route from '@ioc:Adonis/Core/Route'

Route.resource('/merchant_profiles', 'MerchantProfilesController').except(
    ['edit', 'create']
).middleware({
    "*": "auth",
})

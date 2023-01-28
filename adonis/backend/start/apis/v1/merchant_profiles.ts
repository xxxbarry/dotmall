<<<<<<< HEAD
import Route from '@ioc:Adonis/Core/Route'

Route.resource('/merchant_profiles', 'MerchantProfilesController').except(
    ['edit', 'create']
).middleware({
    "*": "auth",
})
=======
import Route from '@ioc:Adonis/Core/Route'

Route.resource('/merchant_profiles', 'MerchantProfilesController').except(
    ['edit', 'create']
).middleware({
    "*": "auth",
})
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

<<<<<<< HEAD
import Route from '@ioc:Adonis/Core/Route'

Route.resource('/stores', 'StoresController').except(
    ['edit', 'create']
).middleware({
    "store": "auth",
    "update": "auth",
    "destroy": "auth",
})
=======
import Route from '@ioc:Adonis/Core/Route'

Route.resource('stores', 'StoresController').except(
  ['edit', 'create']
).middleware({
  "store": "auth",
  "update": "auth",
  "destroy": "auth",
})
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865

import Route from '@ioc:Adonis/Core/Route'

Route.resource('/accounts', 'AccountsController').except(
    ['edit', 'create']
).middleware({
    "*": "auth",
})

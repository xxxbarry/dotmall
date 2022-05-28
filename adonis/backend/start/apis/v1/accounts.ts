import Route from '@ioc:Adonis/Core/Route'

Route.resource('/accounts', 'AccountsController').except(
    ['edit', 'create']
).middleware({
    "*": "auth",
})
// Route.get('/', "AccountsController.index").middleware(['auth'])
// Route.get('/:id', "AccountsController.show").middleware(['auth'])
// Route.post('/', "AccountsController.create").middleware(['auth'])
// Route.delete('/:id', "AccountsController.destroy").middleware(['auth'])

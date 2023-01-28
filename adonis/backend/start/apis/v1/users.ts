/// This route is defined in api/v1/users.ts
/// its purpose is to handle the signup, signin and signout
import Route from '@ioc:Adonis/Core/Route'

Route.post('users/auth/signup', "UsersController.signup")
Route.post('users/auth/signin', "UsersController.signin")
Route.post('users/auth/signout', "UsersController.signout")
Route.get('users/auth', "UsersController.auth")

Route.resource('users', 'UsersController').except(
  ['edit', 'create']
).middleware({
  "store": "auth",
  "update": "auth",
  "destroy": "auth",
})



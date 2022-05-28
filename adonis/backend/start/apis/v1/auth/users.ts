/// This route is defined in api/v1/users.ts
/// its purpose is to handle the signup, signin and signout
import Route from '@ioc:Adonis/Core/Route'

Route.post('/signup', "UsersController.signup")
Route.post('/signin', "UsersController.signin")
Route.post('/signout', "UsersController.signout")


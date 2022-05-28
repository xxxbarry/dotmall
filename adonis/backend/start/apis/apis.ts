
import Route from '@ioc:Adonis/Core/Route'
// Apis
Route.group(() => {

    Route.group(() => {
        require("./v1/auth/users")
    }).prefix("auth/users")
    Route.group(() => {
        require("./v1/accounts")
    })//.prefix("")


}).prefix("api/v1")
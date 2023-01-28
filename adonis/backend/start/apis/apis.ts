
import Route from '@ioc:Adonis/Core/Route'
// Apis
Route.group(() => {

    Route.group(() => {
        require("./v1/auth/users")
    }).prefix("auth/users")
    Route.group(() => {
        require("./v1/accounts")
    })
    Route.group(() => {
        require("./v1/merchant_profiles")
    })
    Route.group(() => {
        require("./v1/customer_profiles")
    })
    Route.group(() => {
        require("./v1/stores")
    })
    

}).prefix("api/v1")
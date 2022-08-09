
import Route from '@ioc:Adonis/Core/Route'
// Apis
Route.group(() => {

  Route.group(() => {
    require("./v1/users")
  })//.prefix("users")
  Route.group(() => {
    require("./v1/addresses")
  })
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
    require("./v1/sections")
    require("./v1/section_translations")
  })
  Route.group(() => {
    require("./v1/stores")
    require("./v1/store_translations")
  })
  Route.group(() => {
    require("./v1/categories")
    require("./v1/category_translations")
  })
  Route.group(() => {
    require("./v1/products")
    require("./v1/product_translations")
  })
  Route.group(() => {
    require("./v1/orders")
    require("./v1/order_items")
  })


}).prefix("api/v1")

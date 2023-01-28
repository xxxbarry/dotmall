/**
 * Contract source: https://git.io/Jte3T
 *
 * Feel free to let us know via PR, if you find something broken in this config
 * file.
 */

import Bouncer from '@ioc:Adonis/Addons/Bouncer'

/*
|--------------------------------------------------------------------------
| Bouncer Actions
|--------------------------------------------------------------------------
|
| Actions allows you to separate your application business logic from the
| authorization logic. Feel free to make use of policies when you find
| yourself creating too many actions
|
| You can define an action using the `.define` method on the Bouncer object
| as shown in the following example
|
| ```
| 	Bouncer.define('deletePost', (user: User, post: Post) => {
|			return post.user_id === user.id
| 	})
| ```
|
|****************************************************************
| NOTE: Always export the "actions" const from this file
|****************************************************************
*/
export const { actions } = Bouncer

/*
|--------------------------------------------------------------------------
| Bouncer Policies
|--------------------------------------------------------------------------
|
| Policies are self contained actions for a given resource. For example: You
| can create a policy for a "User" resource, one policy for a "Post" resource
| and so on.
|
| The "registerPolicies" accepts a unique policy name and a function to lazy
| import the policy
|
| ```
| 	Bouncer.registerPolicies({
|			UserPolicy: () => import('App/Policies/User'),
| 		PostPolicy: () => import('App/Policies/Post')
| 	})
| ```
|
|****************************************************************
| NOTE: Always export the "policies" const from this file
|****************************************************************
*/
export const { policies } = Bouncer.registerPolicies({
<<<<<<< HEAD
    StorePolicy: () => import('App/Policies/StorePolicy'),
    ProductPolicy: () => import('App/Policies/ProductPolicy'),
    CategoryPolicy: () => import('App/Policies/CategoryPolicy'),
    OrderPolicy: () => import('App/Policies/OrderPolicy'),
    ProfilePolicy: () => import('App/Policies/ProfilePolicy'),
    /////////
    AccountPolicy: () => import('App/Policies/AccountPolicy'),
    MerchantPolicy: () => import('App/Policies/MerchantPolicy'),
    CustomerPolicy: () => import('App/Policies/CustomerPolicy')
=======
  StorePolicy: () => import('App/Policies/StorePolicy'),
  UserPolicy: () => import('App/Policies/UserPolicy'),
  ProductPolicy: () => import('App/Policies/ProductPolicy'),
  SectionPolicy: () => import('App/Policies/SectionPolicy'),
  CategoryPolicy: () => import('App/Policies/CategoryPolicy'),
  OrderPolicy: () => import('App/Policies/OrderPolicy'),
  OrderItemPolicy: () => import('App/Policies/OrderItemPolicy'),
  ProfilePolicy: () => import('App/Policies/ProfilePolicy'),
  /////////
  AccountPolicy:  () => import('App/Policies/AccountPolicy'),
  MerchantPolicy: () => import('App/Policies/MerchantPolicy'),
  CustomerPolicy: () => import('App/Policies/CustomerPolicy'),
  /////////
  AddressPolicy: () => import('App/Policies/AddressPolicy'),
  StoreTranslationPolicy: () => import('App/Policies/StoreTranslationPolicy'),
  CategoryTranslationPolicy: () => import('App/Policies/CategoryTranslationPolicy'),
  SectionTranslationPolicy: () => import('App/Policies/SectionTranslationPolicy'),
  ProductTranslationPolicy: () => import('App/Policies/ProductTranslationPolicy'),
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
})

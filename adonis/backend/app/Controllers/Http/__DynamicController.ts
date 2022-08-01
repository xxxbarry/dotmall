/// TODO: continue on dart


// import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
// import Account, { AccountType } from 'App/Models/Account'
// import CreateAccountValidator, { DestroyAccountValidator, ListAccountsValidator, ShowAccountValidator, UpdateAccountValidator } from 'App/Validators/AccountValidator'
// import { Image } from 'App/Models/File'
// import { ModelObject } from '@ioc:Adonis/Lucid/Orm';
// /**
//  * Dynamic controller is a special type of controller that is generated dynamically
//  * you just need to specify the model and the validator.
//  * the validator is used to validate the input data before creating the model.
//  * Dynamic controller is accepted [index, store, show, update, destroy]
//  * 
//  */
// export default class DynamicController {
//   /**
//    * Constructor
//    * @param { HttpContextContract }  ctx
//    * @param { Map<String,DynamicValidator> }  validator
//    * @returns index 
//    */
//   constructor(scope:string, context: HttpContextContract, validator: Map<String, DynamicValidator>) {
//     this.context = context
//     this.validator = validator
//     this.generateRoutes(scope)
//   }

//   /**
//    * validator
//    * @type { Map<String,DynamicValidator> }
//    * @memberof DynamicController
//    */
//   private validator: Map<String, DynamicValidator>;
//   /**
//    * context
//    * @type { HttpContextContract }
//    * @memberof DynamicController
//    */
//   private context: HttpContextContract;

//   /**
//    * generateRoutes
//    * generates the routes for the dynamic controller
//    * @example
//    * ```ts
//    * var postsController = new DynamicController("posts", ctx, validator)
//    * postsController.generateRoutes()
//    * ```
//    * @param {String} scope
//    * @memberof DynamicController
//    */
//   public generateRoutes(scope: string) {
//   }
// }

// /**
//  * DynamicValidator is a special type of validator that is generated dynamically
//  * you just need to specify the action and the validator.
//  * 
//  */
// export class DynamicValidator {
// }


// /**
//  * ActionHandler is a special type of handler that is generated dynamically
//  * you just need to specify the action and the handler.
//  */
// export class DynamicAction {

// }
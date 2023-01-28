// import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
// import CreateModelValidator, { DestroyModelValidator, ListModelsValidator, ShowModelValidator, UpdateModelValidator } from 'App/Validators/ModelValidator'
// import { Image } from 'App/Models/File'
// import { ModelObject } from '@ioc:Adonis/Lucid/Orm';
// import DotBaseModel from 'Dot/models/DotBaseModel';
// import DotValidator, { DotValidators } from 'App/Validators/DotValidator';

// export default class Controller /* extends BaseController */ {

// }
// export class DotController extends Controller {
//     model: DotBaseModel;
//     validators: DotValidators;
//     /**
//      * Constructor
//      * @param { ModelObject }  model
//      * @param { Map<String,DynamicValidator> }  validator
//      * @returns index 
//      */
//     constructor(model: DotBaseModel) {
//         super();
//         this.model = model
//         this.validators = model.validators;
//     }
// }

// enum ControllerActions {
//     index = "get",
//     show = "get",
//     store = "post",
//     update = "put",
//     destroy = "delete",
// }
// class ControllerAction {
//     public path: string
//     public method: string
//     public action: ControllerActions
//     constructor(path: ControllerActions, method: string, action: ControllerActions) {
//         this.path = path
//         this.method = method
//         this.action = action
//     }
// }
// class ControllerRegister {
//     public actions: Set<ControllerAction> = new Set();

// }

// //// routes

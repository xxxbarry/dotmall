<<<<<<< HEAD

import DotBaseModel from "./DotBaseModel";

/** the model addon is something like mixin on class but for the model
   it add some additional properties to the model
   it used in cases when we need to add some additional properties to the model
   for example: Product model has a global properties like: name, description, price, etc.
   if we need to add other type of Product like restaurant product we can create a new model
   but with the model addon we can add some additional properties to the model.
   for example:
   Product:
    - name
    - description
    - price
   ProductRestaurantAddon:
    - productId
    - status
    - restaurantId
    - etc..
  
   we can create a new model like this:
   ```ts
class ProductRestaurantAddon extends ModelAddon {
    @column()
    public productId: string
    @column()
    public status: string
    @column()
    public restaurantId: string
    @belongsTo(() => Product)
    public product: BelongsTo<typeof Product>
}
   ```
   and then we can use it like this:
   ```ts
    class Product extends Model {
        @hasOne(() => ProductRestaurantAddon, { foreignKey: 'productId' })
        public productRestaurantAddon: HasOne<typeof ProductRestaurantAddon>
    }
   ```
 */
export default class ModelAddon extends DotBaseModel {
    // TODO: add some additional properties to the model
    // This part is not completed yet
=======

import DotBaseModel from "./DotBaseModel";

/** the model addon is something like mixin on class but for the model
   it add some additional properties to the model
   it used in cases when we need to add some additional properties to the model
   for example: Product model has a global properties like: name, description, price, etc.
   if we need to add other type of Product like restaurant product we can create a new model
   but with the model addon we can add some additional properties to the model.
   for example:
   Product:
    - name
    - description
    - price
   ProductRestaurantAddon:
    - productId
    - status
    - restaurantId
    - etc..
  
   we can create a new model like this:
   ```ts
class ProductRestaurantAddon extends ModelAddon {
    @column()
    public productId: string
    @column()
    public status: string
    @column()
    public restaurantId: string
    @belongsTo(() => Product)
    public product: BelongsTo<typeof Product>
}
   ```
   and then we can use it like this:
   ```ts
    class Product extends Model {
        @hasOne(() => ProductRestaurantAddon, { foreignKey: 'productId' })
        public productRestaurantAddon: HasOne<typeof ProductRestaurantAddon>
    }
   ```
 */
export default class ModelAddon extends DotBaseModel {
    // TODO: add some additional properties to the model
    // This part is not completed yet
>>>>>>> 423608d22a1abdf567c0150bf4f5b0bb3a406865
}
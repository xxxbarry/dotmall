/*
|--------------------------------------------------------------------------
| Preloaded File
|--------------------------------------------------------------------------
|
| Any code written inside this file will be executed during the application
| boot.
|
*/
import { string } from '@ioc:Adonis/Core/Helpers'
import { validator } from '@ioc:Adonis/Core/Validator'
import Phone from 'App/Models/ContactOptions/Phone'
import { AuthPivotTags } from 'App/Models/User'

validator.rule('authUserPhoneExists', async (value, params, options) => {
  const phone = await Phone.query()
    .where('value', value)
    .first()
  var failed = false
  if (phone) {
    const pivot = await phone.related('users').pivotQuery().where('tag', AuthPivotTags.user).first()
    if (!pivot) {
      failed = true;
    }
  } else {
    failed = true;
  }
  if (failed) {
    options.errorReporter.report(
      options.pointer,
      'authUserPhone',
      'authUserPhone validation failed',
      options.arrayExpressionPointer
    )
  }
  // options.pointer = "options.pointer"
  // options.arrayExpressionPointer = "options.arrayExpressionPointer"
  // options.tip = "options.tip"
  // options.field = "options.field"
  // options.mutate = (value) => {
  //   return "options.mutate"
  // }

},
  (options, type, subtype) => {
    if (subtype !== 'string') {
      throw new Error('"authUserPhoneExists" rule can only be used with a string schema type')
    }

    return {
      async: true,
    }
  }
)

import { string } from '@ioc:Adonis/Core/Helpers'
import { validator } from '@ioc:Adonis/Core/Validator'
import Phone from 'App/Models/ContactOptions/Phone'

// validator.rule('uniquePhone', async (value, params, options) => {
//     if (typeof value !== 'string') {
//         return
//     }
//     // for each phone number in table of phones
//     // check if rolatedType is the same as the current model
//     // if so, check if the phone number is the same
//     // if so, return false
//     // if not, return true
//     const phones = await Phone.query()
//         .where('relatedTo', 'User')
//         .where('number', value)
//         .first()
//     if (phones) {
//         options.errorReporter.report(
//             options.pointer,
//             'uniquePhone',
//             'uniquePhone validation failed',
//             options.arrayExpressionPointer
//         )
//     }
// })

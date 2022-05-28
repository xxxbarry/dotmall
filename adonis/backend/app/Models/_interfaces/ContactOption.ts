import { BaseModel, BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import { DateTime } from 'luxon'
import Email from '../ContactOptions/Email'
import Phone from '../ContactOptions/Phone'
// import Email from '../ContactOptions/Email'
// import Phone from '../ContactOptions/Phone'
import User from '../User'
// this abstraction manages the cridentials of the user like email, phone, or others
// evry [ContactOption] should be unique and have a unique [ContactOption.type]
// also may have a validator to validate the [ContactOption.value]
// *in phone example, the [ContactOption.value] should be a valid phone number (send sms or call)
// *in email example, the [ContactOption.value] should be a valid email (send email to validate)
// *username does not have a validator, validated_at is the creation date of the [ContactOption]
//
// Every [ContactOption] should have a test method to see if input string matches RegEx

export default abstract class ContactOption {
    // Methods are abstracted to allow for different types of contact options
    // like email, phone, etc.
    // static list of all types of contact options children
    // static types = [Email, Phone]
    // static test(value: string) {
    //     var list:any = []
    //     for (let type of ContactOption.types) {
    //         list.push(type.test(value))
    //     }
        // this.types.forEach(type => {
        //     if (type.test(value)) {
        //         return {
        //             type: type.name,
        //             value: value,
        //         }
        //     }
        // })
    //     return list
    // }

}

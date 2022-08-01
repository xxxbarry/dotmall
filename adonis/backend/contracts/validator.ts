declare module '@ioc:Adonis/Core/Validator' {
    interface Rules {
        // authUserPhoneExists(options: DbRowCheckOptions): Rule
      authUserPhoneExists(): Rule
    }
}

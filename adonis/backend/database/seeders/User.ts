import BaseSeeder from '@ioc:Adonis/Lucid/Seeder'
import faker from '@faker-js/faker';
import User from 'App/Models/User';
export default class UserSeeder extends BaseSeeder {
  public async run () {
    // for (let i = 0; i < 5; i++) {
    //   var user = await User.create({
    //     password: "password",
    //   })
    //   await user.related('emails').createMany([
    //     {
    //       value: faker.internet.email(),
    //     },
    //     {
    //       value: faker.internet.email(),
    //     },
    //   ])
    //   await user.related('phones').createMany([
    //     {
    //       value: faker.phone.phoneNumber("#########"),
    //     },
    //     {
    //       value: faker.phone.phoneNumber("#########"),
    //     },
    //   ])
    // }
  }
}

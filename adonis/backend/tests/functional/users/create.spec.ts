import { test } from '@japa/runner'
import Logger from '@ioc:Adonis/Core/Logger'

test.group('Auth:user', () => {
  var token: string
  test('signup user', async ({ client, }) => {
    const response = await client.post('/api/v1/auth/users/signup', ).headers({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }).fields({
      phone: '213657606315',
      password: 'mail@mail',
    }).send()
    response.assertStatus(200)
  })
  // signin user
  test('signin user', async ({ client, }) => {
    const response = await client.post('/api/v1/auth/users/signin', ).headers({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }).fields({
      phone: '213657606315',
      password: 'mail@mail',
    }).send()
    response.assertStatus(200)
    token = response.body().token.token
  })
  // create account
  test('create account', async ({ client, }) => {
    const response = await client.post('/api/v1/accounts', ).headers({
      'Content-Type'  : 'application/json',
      'Accept'        : 'application/json',
      'Authorization' : `Bearer ${token}`,
    }).fields({
      name: 'test account',
      description: 'test account',
      type: 'test account',
    }).send()
    response.assertStatus(200)
  })
  // signout user
  test('signout user', async ({ client, }) => {
    const response = await client.post('/api/v1/auth/users/signout', ).headers({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': `Bearer ${token}`,
    }).send()
    response.assertStatus(200)
  })

})

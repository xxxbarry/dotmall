class {{name.snakeCase()}} {
  {{name.snakeCase()}}() {
    // Hello World
  }

  {{#methods}}
  {{method.name}}() {
    // {{method.description}}
  }
  {{/methods}}
}
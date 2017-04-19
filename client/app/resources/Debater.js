import Resource from './Resource'
import ApiResource from './ApiResource'

export class Debater extends Resource {
  constructor (id) {
    super('debater', id)
  }
}

export class ApiDebater extends ApiResource {
  constructor (id) {
    super('debater', id)
  }
}

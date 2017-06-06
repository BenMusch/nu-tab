import Resource from './Resource'
import ApiResource from './ApiResource'

export class School extends Resource {
  constructor (id) {
    super('school', id)
  }
}

export class ApiSchool extends ApiResource {
  constructor (id) {
    super('school', id)
  }
}

import Resource from './Resource'

export default class ApiResource extends Resource {
  constructor(name, id) {
    super(name, id)
  }

  pathTo = () => {
    const listPath = `/api/${this.name}s`
    const individualPath = `${listPath}/${this.id}`
    return {
      index: listPath,
      new: `${listPath}/new`,
      create: listPath,
      show: individualPath,
      edit: `${individualPath}/edit`,
      update: individualPath,
      destroy: individualPath
    }
  }
}

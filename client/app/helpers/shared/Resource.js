import axios from 'axios'
import ReactOnRails from 'react-on-rails'

export default class Resource {
  constructor(name, id) {
    this.name = name
    this.id = id
  }

  pathTo () {
    const listPath = `/${this.name}s`
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

  authenticityTokenObject () {
    return {authenticity_token: ReactOnRails.authenticityToken()}
  }

  index () {
    return axios.get(this.pathTo().index, this.authenticityTokenObject())
  }

  new () {
    return axios.get(this.pathTo().new, this.authenticityTokenObject())
  }

  create (resourceData) {
    let data = {}
    data[this.name] = resourceData
    return axios
      .post(this.pathTo().create, {...data, ...this.authenticityTokenObject()})
  }

  show () {
    return axios.get(this.pathTo().show, this.authenticityTokenObject())
  }

  edit () {
    return axios.get(this.pathTo().edit, this.authenticityTokenObject())
  }

  update (resourceData) {
    let data = {}
    data[this.name] = resourceData
    return axios
      .put(this.pathTo().update, {...data, ...this.authenticityTokenObject()})
  }

  destroy () {
    return axios.request({
      url: this.pathTo().destroy,
      method: 'DELETE',
      data: this.authenticityTokenObject()
    })
  }
}

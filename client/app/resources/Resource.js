import axios from 'axios'
import ReactOnRails from 'react-on-rails'

export default class Resource {
  constructor (name, id) {
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

  index (ext) {
    return axios.get(this.pathTo().index + this._extension(ext), this.authenticityTokenObject())
  }

  new (ext) {
    return axios.get(this.pathTo().new + this._extension(ext), this.authenticityTokenObject())
  }

  create (resourceData, ext) {
    let data = {}
    data[this.name] = resourceData
    return axios
      .post(this.pathTo().create + this._extension(ext), {...data, ...this.authenticityTokenObject()})
  }

  show () {
    return axios.get(this.pathTo().show + this._extension(ext), this.authenticityTokenObject())
  }

  edit () {
    return axios.get(this.pathTo().edit + this._extension(ext), this.authenticityTokenObject())
  }

  update (resourceData, ext) {
    let data = {}
    data[this.name] = resourceData
    return axios
      .put(this.pathTo().update + this._extension(ext), {...data, ...this.authenticityTokenObject()})
  }

  destroy (ext) {
    return axios.request({
      url: this.pathTo().destroy + this._extension(ext),
      method: 'DELETE',
      data: this.authenticityTokenObject()
    })
  }

  _extension(extension) {
    if (extension) {
      return `.${extension}`
    } else {
      return ''
    }
  }
}

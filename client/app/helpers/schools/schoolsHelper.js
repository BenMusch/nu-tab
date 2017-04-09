import ReactOnRails from 'react-on-rails'
import axios from 'axios'

export const updateSchool = (path, updates) => {
  return axios.put(path,
    {school: updates, authenticity_token: ReactOnRails.authenticityToken()})
}

export const createSchool = (school) => {
  return axios.post('/schools',
    {school: school, authenticity_token: ReactOnRails.authenticityToken()})
}

export const deleteSchool = (school) => {
  return axios.request({
    url: school.show_path,
    method: 'delete',
    data: {authenticity_token: ReactOnRails.authenticityToken()}
  })
}

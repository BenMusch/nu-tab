import ReactOnRails from 'react-on-rails'
import axios from 'axios'

export const updateSchool = (path, updates) => {
  return axios.put(path,
    {school: updates, authenticity_token: ReactOnRails.authenticityToken()})
}

import ReactOnRails from 'react-on-rails'

import {SchoolList, SchoolItem, SchoolDetail} from '../components/schools'

console.log('updating!')
ReactOnRails.register({
  SchoolList,
  SchoolItem,
  SchoolDetail
})

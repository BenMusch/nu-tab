import ReactOnRails from 'react-on-rails'

import {SchoolListContainer, SchoolList, SchoolItem, SchoolDetail} from '../components/schools'
import {DebaterList, DebaterItem, DebaterDetail, DebaterForm, DebaterContainer, DebaterListContainer} from '../components/debaters'
import EditableText from '../components/shared/EditableText'

ReactOnRails.register({
  EditableText,
  SchoolListContainer,
  SchoolItem,
  SchoolDetail,
  SchoolList,
  DebaterList,
  DebaterItem,
  DebaterDetail,
  DebaterForm,
  DebaterContainer,
  DebaterListContainer
})

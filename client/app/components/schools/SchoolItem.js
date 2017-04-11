import React, {PropTypes} from 'react'
import School from '../../resources/School'

export const SchoolItem = (props) => {
  return (
    <li><a href={new School(props.id).pathTo().show}>{props.name}</a></li>
  )
}

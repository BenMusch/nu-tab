import React, {PropTypes} from 'react'
import {SchoolItem} from './SchoolItem'

export const SchoolList = (props) => {
  return (
    <ul>
      {props.schools.map((school) => {
        return <SchoolItem {...school} key={school.id} />
      })}
    </ul>
  )
}

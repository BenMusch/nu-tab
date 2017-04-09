import React, {PropTypes} from 'react'
import {SchoolItem} from './SchoolItem'

export const SchoolList = (props) => {
  console.log('hello')
  return (<ul>
    {props.schools.map((school) => {
      return <SchoolItem {...school} key={school.id} />
    })}
  </ul>)
}

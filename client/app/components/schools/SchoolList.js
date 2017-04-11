import React from 'react'
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

SchoolList.propTypes = {
  schools: React.PropTypes.array
}

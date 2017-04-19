import React from 'react'
import {SchoolItem} from './SchoolItem'

export const SchoolList = (props) => {
  return (
    <ul className="schools">
      {props.schools.map((school) => {
        return <SchoolItem {...school} key={school.id} />
      })}
    </ul>
  )
}

SchoolList.propTypes = {
  schools: React.PropTypes.array.isRequired
}

SchoolList.defaultProps = {
  schools: []
}

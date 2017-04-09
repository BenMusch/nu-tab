import React, {PropTypes} from 'react'

export const SchoolDetail = (props) => {
  return (
    <div className="school">
      <h1>{props.school.name}</h1>
    </div>
  )
}

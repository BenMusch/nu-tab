import React, {PropTypes} from 'react'

export const SchoolItem = (props) => {
  return (
    <li><a href={props.show_path}>{props.name}</a></li>
  )
}

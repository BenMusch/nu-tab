import React from 'react'
import {School} from '../../resources/School'

export const SchoolItem = (props) => {
  return (
    <li><a href={new School(props.id).pathTo().show}>{props.name}</a></li>
  )
}

SchoolItem.propTypes = {
  id: React.PropTypes.number.isRequired,
  name: React.PropTypes.string.isRequired
}

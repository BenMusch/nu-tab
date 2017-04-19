import React from 'react'
import Debater from '../../resources/Debater'

export const DebaterItem = (props) => {
  const debater = new Debater(props.id)
  return (
    <li><a href={debater.pathTo(false).show}>{props.name}</a> ({props.school.name})</li>
  )
}

DebaterItem.propTypes = {
  name: React.PropTypes.string.isRequired,
  id: React.PropTypes.number.isRequired,
  school: React.PropTypes.object.isRequired
}

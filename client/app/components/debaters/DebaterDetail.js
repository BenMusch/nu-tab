import React from 'react';
import School from '../../resources/School'
import SchoolSelectField from '../schools/SchoolSelectField'

export const DebaterDetail = (props) => {
  const school = new School(props.school.id)
  return (
    <div className="Debater_detail">
      <h1>{props.name}</h1>
      <span>School: <a href={school.pathTo().show}>{props.school.name}</a></span>
      <br/>
      <span>{props.novice ? 'Novice' : 'Varsity'}</span>
      <SchoolSelectField />
    </div>
  )
}

DebaterDetail.propTypes = {
  name: React.PropTypes.string.isRequired,
  id: React.PropTypes.number.isRequired,
  novice: React.PropTypes.bool.isRequired,
  school: React.PropTypes.object.isRequired
}

import React from 'react'
import _ from 'lodash'
import {SchoolList} from './SchoolList'
import {CreateSchool} from './CreateSchool'
import {createSchool} from '../../helpers/schools/schoolsHelper'

export class SchoolListContainer extends React.Component {
  state = {
    schools: this.props.schools,
    message: ''
  }

  handleAddSchool = (event) => {
    event.preventDefault()
    const formData = new FormData(event.target)
    createSchool({name: formData.get('name')})
      .then((response) => {
        const newSchool = response.data
        const newSchools = this.state.schools.concat(newSchool)
        const sortedSchools = _.sortBy(newSchools, (school) => school.name)
        this.setState({
          message: 'School Added!',
          schools: sortedSchools
        })
      })
      .catch((response) => {
        this.setState({
          message: 'error!'
        })
      })
  }

  render () {
    return (
      <div className='school-list'>
        {this.state.message}
        <CreateSchool handleSubmit={this.handleAddSchool} />
        <SchoolList schools={this.state.schools} />
      </div>
    )
  }
}

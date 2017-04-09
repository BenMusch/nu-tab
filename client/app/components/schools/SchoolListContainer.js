import React from 'react'
import _ from 'lodash'
import {SchoolList} from './SchoolList'
import {CreateSchool} from './CreateSchool'
import {createSchool} from '../../helpers/schools/schoolsHelper'

export class SchoolListContainer extends React.Component {
  state = {
    schools: this.props.schools,
    newSchool: '',
    message: ''
  }

  handleAddSchool = (event) => {
    event.preventDefault()
    createSchool({name: this.state.newSchool})
      .then((response) => {
        const newSchool = response.data
        const newSchools = this.state.schools.concat(newSchool)
        const sortedSchools = _.sortBy(newSchools, (school) => school.name)
        this.setState({
          message: 'School Added!',
          newSchool: '',
          schools: sortedSchools
        })
      })
      .catch((response) => {
        this.setState({
          message: 'error!'
        })
      })
  }

  handleSchoolChange = (event) => {
    this.setState({newSchool: event.target.value})
  }

  render () {
    return (
      <div className='school-list'>
        {this.state.message}
        <CreateSchool handleSubmit={this.handleAddSchool}
                      schoolName={this.state.newSchool}
                      handleInputChange={this.handleSchoolChange} />
        <SchoolList schools={this.state.schools} />
      </div>
    )
  }
}

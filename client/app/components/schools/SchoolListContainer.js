import React from 'react'
import _ from 'lodash'
import {SchoolList} from './SchoolList'
import {CreateSchool} from './CreateSchool'
import {ApiSchool} from '../../resources/School'

export class SchoolListContainer extends React.Component {
  static propTypes = {
    schools: React.PropTypes.array
  }

  state = {
    schools: this.props.schools,
    newSchool: '',
    message: ''
  }

  handleAddSchool = (event) => {
    event.preventDefault()
    new ApiSchool().create({name: this.state.newSchool})
      .then((response) => {
        const newSchool = response.data
        this.setState({
          message: 'School Added!',
          newSchool: '',
          schools: this.state.schools.concat(newSchool)
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

  sortedSchools() {
    return _.sortBy(this.state.schools, (school) => school.name)
  }

  render() {
    return (
      <div className='school_list'>
        {this.state.message}
        <CreateSchool handleSubmit={this.handleAddSchool}
                      schoolName={this.state.newSchool}
                      handleInputChange={this.handleSchoolChange} />
        <SchoolList schools={this.sortedSchools()} />
      </div>
    )
  }
}

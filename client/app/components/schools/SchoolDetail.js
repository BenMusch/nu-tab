import React, {PropTypes} from 'react'
import {Button} from 'react-bootstrap'
import EditableText from '../shared/EditableText'
import School from '../../resources/School'

class SchoolDetail extends React.Component {
  state = {
    school: this.props.school,
    message: ''
  }

  static propTypes = {
    school: PropTypes.object
  }

  deleteSchool = (event) => {
    event.preventDefault()
    let confirmed = confirm('Are you sure? This will delete all of the debaters and judges')
    const school = this.getSchoolObject()
    if (confirmed) {
      school.destroy()
        .then((response) => window.location = school.pathTo().index)
        .catch(() => this.setState({message: 'Could not delete school.'}))
    }
  }

  handleNameUpdate = (name) => {
    if (name.trim() !== this.state.school.name) {
      this.getSchoolObject().update({name})
        .then((response) => {
          this.flashMessage('School updated!')
          this.setState({school: response.data})
        })
        .catch(() => this.flashMessage('Error!'))
    }
  }

  flashMessage = (message) => {
    this.setState({message})
    setTimeout(() => this.setState({message: ''}), 2500)
  }

  getSchoolObject () {
    return new School(this.state.school.id)
  }

  render () {
    return (
      <div className="school">
        {this.state.message}
        <EditableText text={this.state.school.name} name="name"
          onSave={this.handleNameUpdate} />
        <Button onClick={this.deleteSchool} bsStyle="danger">Delete</Button>
      </div>
    )
  }
}

export default SchoolDetail

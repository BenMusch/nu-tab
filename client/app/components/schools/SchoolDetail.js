import React, {PropTypes} from 'react'
import EditableText from '../shared/EditableText'
import {updateSchool, deleteSchool} from '../../helpers/schools/schoolsHelper'

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
    if (confirmed) {
      deleteSchool(this.state.school)
        .then((response) => {
          window.location = '/schools'
        })
        .catch(() => {
          this.setState({message: 'Could not delete school.'})
        })
    }
  }

  handleNameUpdate = (name) => {
    if (name.trim() !== this.state.school.name) {
      updateSchool(this.props.school.show_path, {name})
        .then((response) => {
          this.flashMessage('School updated!')
          this.setState({school: response.school})
        })
        .catch(() => this.flashMessage('Error!'))
    }
  }

  flashMessage = (message) => {
    this.setState({message})
    setTimeout(() => this.setState({message: ''}), 2500)
  }

  render () {
    return (
      <div className="school">
        {this.state.message}
        <EditableText text={this.state.school.name} name="name"
          onSave={this.handleNameUpdate} />
        <a href="#delete" onClick={this.deleteSchool}>Delete</a>
      </div>
    )
  }
}

export default SchoolDetail

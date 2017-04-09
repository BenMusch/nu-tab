import React, {PropTypes} from 'react'
import EditableText from '../shared/EditableText'
import {updateSchool} from '../../helpers/schools/schoolsHelper'

class SchoolDetail extends React.Component {
  state = {
    school: this.props.school,
    message: ''
  }

  static propTypes = {
    school: PropTypes.object
  }

  handleNameUpdate = (name) => {
    if (name.trim() !== this.state.school.name) {
      updateSchool(this.props.school.show_path, {name})
        .then((response) => {
          this.flashMessage('School updated!')
          this.setState({school: response.school})
        })
        .catch(this.flashMessage('Error!'))
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
        <EditableText text={this.state.school.name} name="school_name"
          onSave={this.handleNameUpdate} />
      </div>
    )
  }
}

export default SchoolDetail

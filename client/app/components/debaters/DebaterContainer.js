import React from 'react'
import {Button} from 'react-bootstrap'
import {DebaterForm, DebaterDetail} from './index'
import Debater from '../../resources/Debater'

export class DebaterContainer extends React.Component {
  static propTypes = {
    name: React.PropTypes.string.isRequired,
    novice: React.PropTypes.bool,
    school: React.PropTypes.object.isRequired,
    id: React.PropTypes.number.isRequired
  }

  state = {
    isEditing: false,
    debater: {
      name: this.props.name,
      novice: this.props.novice,
      school: this.props.school,
      id: this.props.id
    },
    message: ''
  }

  handleSuccessfulSubmit = (response) => {
    this.setState({
      debater: response.data,
      message: 'Successfully updated!',
      isEditing: false
    })
  }

  handleFailedSubmit = (response) => this.setState({ message: 'Error!' })

  handleEditClick = () => this.setState({ isEditing: true })

  handleDeleteClick = () =>  {
    const debater = new Debater(this.state.debater.id)
    const confirmed = confirm('Are you sure? This will delete all of this debaters stats and affect their team speaks')
    if (confirmed) {
      debater.destroy()
        .then(() => window.location = debater.pathTo().index)
        .catch(() => this.setState({ message: 'Could not delete this debater' }))
    }
  }

  renderEditor() {
    return (
      <DebaterForm
        {...this.state.debater}
        handleSuccessfulSubmit={this.handleSuccessfulSubmit}
        handleFailedSubmit={this.handleFailedSubmit}
        />
    )
  }

  renderDetail() {
    return <DebaterDetail {...this.state.debater}/>
  }

  render() {
    return (
      <div className="debater_container">
        {this.state.message}
        {this.state.isEditing ? this.renderEditor() : this.renderDetail()}
        {!this.state.isEditing && <Button onClick={this.handleEditClick}>Edit</Button>}
        {!this.state.isEditing && <Button onClick={this.handleDeleteClick} bsStyle="danger">Delete</Button>}
      </div>
    )
  }
}

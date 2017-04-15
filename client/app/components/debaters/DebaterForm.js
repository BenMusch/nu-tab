import React from 'react'
import Autosuggest from 'react-autosuggest'
import {FormControl, ControlLabel, FormGroup, Button} from 'react-bootstrap'
import Debater from '../../resources/Debater'
import SchoolSelectField from '../schools/SchoolSelectField'

export class DebaterForm extends React.Component {
  static propTypes = {
    name: React.PropTypes.string,
    novice: React.PropTypes.bool,
    school: React.PropTypes.object
  }

  state = {
    name: this.props.name || '',
    novice: this.props.novice,
    school: this.props.school || {}
  }

  handleSubmit = (event) => {
    event.preventDefault()
  }

  handleNameChange = (event) => {
    this.setState({name: event.target.value})
  }

  handleSchoolChange = (newValue) => {
    this.setState({school: newValue})
  }

  render() {
    return(
      <div className="debater_form">
        <form id="debater" onSubmit={this.handleSubmit}>
          <FormGroup controlId="name">
            <ControlLabel>Name</ControlLabel>
            <FormControl
             type="text"
             value={this.state.name}
             onChange={this.handleNameChange}
             />
          </FormGroup>
          <SchoolSelectField
           defaultSelection={this.state.school}
           onSelectionChange={this.handleSchoolChange}
           />
        </form>
      </div>
    )
  }
}

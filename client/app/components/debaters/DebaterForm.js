import React from 'react'
import {FormControl, ControlLabel, FormGroup, Button} from 'react-bootstrap'
import Debater from '../../resources/Debater'
import SchoolSelectField from '../schools/SchoolSelectField'

export class DebaterForm extends React.Component {
  static propTypes = {
    name: React.PropTypes.string,
    novice: React.PropTypes.bool,
    school: React.PropTypes.object,
    id: React.PropTypes.number,
    handleSuccessfulSubmit: React.PropTypes.func.isRequired,
    handleFailedSubmit: React.PropTypes.func.isRequired
  }

  static defaultProps = {
    school: { name: '', id: '' },
    name: '',
    novice: false
  }

  state = {
    name: this.props.name,
    novice: this.props.novice,
    school: this.props.school
  }

  handleSubmit = (event) => {
    event.preventDefault()
    const debater = new Debater(this.props.id)
    let request = this.props.id ? debater.update : debater.create
    request(this.paramsToSubmit())
      .then((response) => this.props.handleSuccessfulSubmit(response))
      .catch((response) => this.props.handleFailedSubmit(response))
  }

  handleNameChange = (event) => {
    this.setState({name: event.target.value})
  }

  handleNoviceChange = (event) => {
    this.setState({novice: !this.state.novice})
  }

  handleSchoolChange = (newValue) => {
    this.setState({school: newValue})
  }

  paramsToSubmit() {
    return {
      name: this.state.name,
      school_id: this.state.school.id,
      novice: this.state.novice
    }
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
          <FormGroup controlId="novice">
            <ControlLabel>Novice</ControlLabel>
            <FormControl
             type="checkbox"
             checked={this.state.novice}
             onChange={this.handleNoviceChange}
             />
          </FormGroup>
          <Button type="submit">Save</Button>
        </form>
      </div>
    )
  }
}

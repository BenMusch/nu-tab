import React from 'react'
import _ from 'lodash'
import {Button} from 'react-bootstrap'
import {DebaterList, DebaterForm} from './index'

export class DebaterListContainer extends React.Component {
  static propTypes = {
    debaters: React.PropTypes.array.isRequired
  }

  static defaultProps = {
    debaters: []
  }

  state = {
    debaters: this.props.debaters,
    message: '',
    isAdding: false
  }

  handleSuccesfulSubmit = (response) => {
    this.setState({
      debaters: this.state.debaters.concat(response.data),
      message: 'Successfully updated!',
      isAdding: false
    })
  }

  handleFailedSubmit = (response) => this.setState({ message: 'Error!' })

  handleAddClick = () => this.setState({ isAdding: true })

  sortedDebaters() {
    return _.sortBy(this.state.debaters, ['school.name', 'name'])
  }

  renderForm() {
    return (
      <DebaterForm
        handleSuccessfulSubmit={this.handleSuccesfulSubmit}
        handleFailedSubmit={this.handleFailedSubmit}
      />
    )
  }

  render() {
    return (
      <div className="debater_list">
        {this.state.message}
        {!this.state.isAdding && <Button onClick={this.handleAddClick}>Add Debater</Button>}
        {this.state.isAdding && this.renderForm()}
        <DebaterList debaters={this.sortedDebaters()} />
      </div>
    )
  }
}

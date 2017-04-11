import React, {PropTypes} from 'react'
import {Button, FormControl} from 'react-bootstrap'

class EditableText extends React.Component {
  state = {
    isEditing: false,
    text: this.props.text
  }

  static propTypes = {
    onSave: PropTypes.func,
    text: PropTypes.string,
    name: PropTypes.string
  }

  handleSave = (event) => {
    event.preventDefault()
    this.toggleEditState()
    this.props.onSave(this.state.text)
  }

  handleEditClick = (event) => {
    event.preventDefault()
    this.toggleEditState()
  }

  handleInputChange = (event) => {
    event.preventDefault()
    this.setState({text: event.target.value})
  }

  toggleEditState () {
    this.setState({isEditing: !this.state.isEditing})
  }

  renderText () {
    return (
      <div className="display">
        <h1>{this.props.text}</h1>
        <Button onClick={this.handleEditClick}>Edit</Button>
      </div>
    )
  }

  renderEditor () {
    return (
      <form className="edit" onSubmit={this.handleSave}>
        <FormControl
          type="text"
          value={this.state.text}
          name={this.props.name}
          onChange={this.handleInputChange}
        />
        <Button type="submit">Save</Button>
      </form>
    )
  }

  render () {
    return (
      <div className="editable-text">
        {this.state.isEditing ? this.renderEditor() : this.renderText()}
      </div>
    )
  }
}

export default EditableText

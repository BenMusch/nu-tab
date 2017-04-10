import React, {PropTypes} from 'react'

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

  handleSaveClick = (event) => {
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
        <a href="#edit" onClick={this.handleEditClick}>edit</a>
      </div>
    )
  }

  renderEditor () {
    return (
      <div className="edit">
        <input type="text" name={this.props.name} onChange={this.handleInputChange} value={this.state.text}/>
        <a href="#save" onClick={this.handleSaveClick}>save</a>
      </div>
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

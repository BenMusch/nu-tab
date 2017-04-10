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
        <a href="#edit" onClick={this.handleEditClick}>edit</a>
      </div>
    )
  }

  renderEditor () {
    return (
      <form className="edit" onSubmit={this.handleSave}>
        <input type="text" className="form-control" name={this.props.name} onChange={this.handleInputChange} value={this.state.text}/>
        <input type="submit" value="save"/>
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

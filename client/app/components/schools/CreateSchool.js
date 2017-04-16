import React from 'react'
import {FormControl, ControlLabel, FormGroup, Button} from 'react-bootstrap'

export const CreateSchool = (props) => {
  return (
    <form onSubmit={props.handleSubmit} id="create_school">
      <FormGroup controlId="name">
        <ControlLabel>New School</ControlLabel>
        <FormControl
         type="text"
         value={props.schoolName}
         onChange={props.handleInputChange}
         placeholder="School name"
         name="name"
         />
      </FormGroup>
      <Button type="submit">Submit</Button>
    </form>
  )
}

CreateSchool.propTypes = {
  handleSubmit: React.PropTypes.func,
  handleInputChange: React.PropTypes.func,
  schoolName: React.PropTypes.string
}

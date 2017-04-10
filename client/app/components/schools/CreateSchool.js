import React from 'react'

export const CreateSchool = (props) => {
  return (
    <form onSubmit={props.handleSubmit} id="create-school">
      <label htmlFor="name">New School</label>
      <input type="text" placeholder="School Name" name="name"
             value={props.schoolName} onChange={props.handleInputChange}/>
      <input type="submit" value="Submit"/>
    </form>
  )
}

import React from 'react'

export const CreateSchool = (props) => {
  return (
    <form onSubmit={props.handleSubmit} id="create-school">
      <input type="text" placeholder="School Name" name="name"/>
      <input type="submit" value="Submit"/>
    </form>
  )
}

import React from 'react'
import {DebaterItem} from './DebaterItem'

export const DebaterList = (props) => {
  return (
    <ul className="debaters">
      {props.debaters.map((debater) => {
        return <DebaterItem {...debater} key={debater.id} />
      })}
    </ul>
  )
}

DebaterList.propTypes = {
  debaters: React.PropTypes.array.isRequired
}

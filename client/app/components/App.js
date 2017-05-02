import { connect } from 'react-redux'

const mapStateToProps = (state) => {
  return {
    debaters: state.debaters,
    schools: state.schools
  }
}

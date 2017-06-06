import React from 'react'
import Autosuggest from 'react-autosuggest'
import {ControlLabel, FormGroup} from 'react-bootstrap'
import {ApiSchool} from '../../resources/School'

const preprocessName = (name) => name.trim().toLowerCase()

const getSuggestionValue = (school) => school.name

const renderSuggestion = (school) =>  {
  return <div className="suggestion">{school.name}</div>
}

const getSuggestions = (value, options) => {
  const inputValue = preprocessName(value);
  const inputLength = inputValue.length;

  return inputLength === 0 ? [] : options.filter((school) => {
    const inc = preprocessName(school.name).includes(inputValue)
    return inc
  });
};

const emptySchool = { name: '', id: '' }

export default class SchoolSelectField extends React.Component {
  static propTypes = {
    onSelectionChange: React.PropTypes.func,
    defaultSelection: React.PropTypes.object
  }

  static defaultProps = {
    defaultSelection: emptySchool
  }

  state = {
    suggestions: [],
    schools: [],
    selectedSchool: this.props.defaultSelection,
    value: this.props.defaultSelection.name
  }

  componentDidMount() {
    new ApiSchool().index()
      .then((response) => this.setState({schools: response.data.data}))
  }

  onSuggestionsClearRequested = () => {
    this.setState({suggestions: this.state.schools})
  }

  onSuggestionsFetchRequested = ({ value }) => {
    if (preprocessName(value) !== preprocessName(this.state.selectedSchool.name)) {
      const suggestions = getSuggestions(value, this.state.schools)
      this.setState({suggestions: suggestions, selectedSchool: emptySchool})
      if (this.props.onSelectionChange) this.props.onSelectionChange(emptySchool)
    }
  }

  onChange = (event, { newValue }) => {
    this.setState({value: newValue || ''})
  }

  onSuggestionSelected = (event, { suggestion }) => {
    this.setState({ selectedSchool: suggestion })
    if (this.props.onSelectionChange) this.props.onSelectionChange(suggestion)
  }

  render() {
    const inputProps = {
      placeholder: 'Type a school name',
      value: this.state.value,
      onChange: this.onChange,
      default: this.state.selectedSchool.name,
      id: 'select_school',
      name: 'school_name',
      className: 'form-control'
    }

    return (<FormGroup controlId="school_select">
      <ControlLabel>School</ControlLabel>
      <Autosuggest
        suggestions={this.state.suggestions}
        onSuggestionsFetchRequested={this.onSuggestionsFetchRequested}
        onSuggestionsClearRequested={this.onSuggestionsClearRequested}
        getSuggestionValue={getSuggestionValue}
        onSuggestionSelected={this.onSuggestionSelected}
        renderSuggestion={renderSuggestion}
        inputProps={inputProps}
      />
      <input name="school_id" value={this.state.selectedSchool.id} type="hidden"/>
    </FormGroup>)
  }
}

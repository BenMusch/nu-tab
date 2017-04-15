import React from 'react'
import Autosuggest from 'react-autosuggest'
import School from '../../resources/School'

const getSuggestionValue = (school) => school.name

const renderSuggestion = (school) =>  {
  return <div className="suggestion">{school.name}</div>
}

const getSuggestions = (value, options) => {
  const inputValue = value.trim().toLowerCase();
  const inputLength = inputValue.length;

  return inputLength === 0 ? [] : options.filter((school) => {
    console.log(inputValue)
    const inc = school.name.toLowerCase().includes(inputValue)
    console.log(inc)
    return inc
  });
};

export default class SchoolSelectField extends React.Component {
  constructor() {
    super()
    this.state = {
      suggestions: [],
      schools: [],
      selectedSchool: {},
      value: ''
    }
  }

  componentDidMount() {
    console.log('mount')
    new School().index('json')
      .then((response) => this.setState({ schools: response.data }))
  }

  onSuggestionsClearRequested = () => {
    this.setState({ suggestions: this.state.schools })
  }

  onSuggestionsFetchRequested = ({ value }) => {
    const suggestions = getSuggestions(value, this.state.schools)
    this.setState({ suggestions: suggestions , selectedSchool: {}})
  }

  onChange = (event, { newValue }) => {
    this.setState({ value: newValue || '' })
  }

  onSuggestionSelected = (event, { suggestion }) => {
    this.setState({ selectedSchool: suggestion })
  }

  render() {
    const inputProps = {
      placeholder: 'Type a school name',
      value: this.state.value,
      onChange: this.onChange,
    }

    return (<div className="School_select">
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
    </div>)
  }
}

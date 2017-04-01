import HelloComponent from '../../components/HelloComponent'

describe('HelloComponent', function() {
  it('should render a hello world message', function() {
    let renderedComponent = React.addons.TestUtils.renderIntoDocument(<HelloComponent/>);
    expect(renderedComponent.getDOMNode().textContent).toBe('Hello, world');
  })
})

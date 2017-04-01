import React from 'react';
import {shallow} from 'enzyme';
import HelloWorld from '../../bundles/HelloWorld/components/HelloWorld';

describe('HelloComponent', () => {
  test('Rendering a hello world message', () => {
    const helloWorld = shallow(<HelloWorld />)
    expect(helloWorld.text()).toBe('Hello, world!');
  })
})

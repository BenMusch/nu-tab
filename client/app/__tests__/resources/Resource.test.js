import Resource from '../../resources/Resource'

test('pathTo should generate the RESTful routes', () => {
  const resource = new Resource('resource', 2)
  expect(resource.pathTo().index).toEqual('/resources')
  expect(resource.pathTo().new).toEqual('/resources/new')
  expect(resource.pathTo().create).toEqual('/resources')
  expect(resource.pathTo().show).toEqual('/resources/2')
  expect(resource.pathTo().edit).toEqual('/resources/2/edit')
  expect(resource.pathTo().update).toEqual('/resources/2')
  expect(resource.pathTo().destroy).toEqual('/resources/2')
})

import Resource from '../../helpers/shared/Resource'

export const updateSchool = (id, schoolData) => {
  return new Resource('school', id).update(schoolData)
}

export const createSchool = (schoolData) => {
  return new Resource('school').create(schoolData)
}

export const deleteSchool = (id) => {
  return new Resource('school', id).destroy()
}

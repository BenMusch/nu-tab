# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'Viewing schools', js: true do
  let!(:schools)            { create_list(:school, 5) }
  let(:school)              { schools.first }
  let(:invalid_school_name) { 'Name Invalid Because It Is Too Long' }

  scenario 'viewing all school' do
    visit schools_path
    schools.each do |school|
      expect(page).to have_link school.name
    end

    click_on school.name
    expect(page).to have_content school.name
  end

  scenario 'creating a school' do
    visit schools_path

    fill_in 'name', with: invalid_school_name
    click_on 'Submit'
    expect(page).not_to have_link invalid_school_name

    fill_in 'name', with: 'New School'
    click_on 'Submit'

    expect(page).to have_link('New School')
    click_on 'New School'
    expect(page).to have_content('New School')

    visit schools_path
    expect(page).to have_content('New School')
  end

  scenario 'editing a school' do
    visit schools_path
    click_on school.name

    expect(page).to have_content school.name
    click_on 'edit'

    fill_in 'name', with: invalid_school_name
    click_on 'save'
    expect(page).not_to have_content invalid_school_name

    click_on 'edit'
    fill_in 'name', with: 'New School Name'
    click_on 'save'

    expect(page).to have_content 'New School Name'
    visit school_path(school)
    expect(page).to have_content 'New School Name'
  end

  scenario 'deleting a school' do
    visit school_path(school)
    click_on 'Delete'
    expect(page).not_to have_link school.name
  end
end

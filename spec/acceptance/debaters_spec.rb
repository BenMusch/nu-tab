# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'Viewing debaters', js: true do
  let(:school)       { create(:school) }
  let!(:debater)     { create(:debater, name: 'Josh Spiegel', novice: false, school: school) }
  let!(:debaters)    { create_list(:debater, 2, school: create(:school)) }
  let(:invalid_name) { 'a' * 51 }

  scenario 'viewing debaters' do
    visit debaters_path
    debaters.each do |debater|
      expect(page).to have_link debater.name
    end

    click_on debater.name
    expect(page).to have_content debater.name
    expect(page).to have_link school.name
    expect(page).to have_content 'Varsity'
  end

  scenario 'creating a debater' do
    # sad path
    visit debaters_path
    click_on 'Add Debater'
    fill_in 'Name', with: invalid_name
    select_school school.name
    find('#novice').click
    click_on 'Save'
    expect(page).not_to have_content invalid_name

    # happy path!
    visit debaters_path
    click_on 'Add Debater'
    fill_in 'Name', with: 'Ben Muschol'
    select_school school.name
    find('button', text: 'Save').click
    expect(page).to have_link 'Ben Muschol'
  end

  scenario 'deleting a debater' do
    visit debater_path(debater)
    click_on 'Delete'
    page.accept_confirm
    visit debaters_path
    expect(page).not_to have_content debater.name
  end

  scenario 'editing a debater' do
    new_school = create(:school)
    visit debater_path(debater)
    expect(page).to have_content debater.name
    expect(page).to have_content 'Varsity'
    expect(page).to have_content school.name

    click_on 'Edit'

    fill_in 'Name', with: 'New Name'

    # delete the currently filled in school
    school.name.length.times do
      find('#select_school').send_keys(:backspace)
    end

    select_school new_school.name
    find('#novice').click
    click_on 'Save'

    expect(page).to have_content 'New Name'
    expect(page).to have_content 'Novice'
    expect(page).to have_content new_school.name
  end
end

def select_school(name)
  find('#select_school').send_keys(name)
  find('.suggestion', text: name).click
end

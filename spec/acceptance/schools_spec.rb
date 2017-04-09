# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'Viewing schools', js: true do
  let!(:schools) { create_list(:school, 5) }
  let(:school) { schools.first }

  scenario 'viewing all school' do
    visit schools_path
    schools.each do |school|
      expect(page).to have_link school.name
    end

    click_on school.name
    expect(page).to have_content school.name
  end

  scenario 'editing a school' do
  end

  scenario 'deleting a school' do
  end
end

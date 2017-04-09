# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'hello world', js: true do
  scenario 'viewing the home page' do
    visit '/'
    binding.pry
  end
end

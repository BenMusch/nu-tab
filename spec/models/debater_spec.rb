# == Schema Information
#
# Table name: debaters
#
#  id         :integer          not null, primary key
#  name       :string
#  novice     :boolean
#  school_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Debater, type: :model do
  describe 'name' do
    it 'is present' do

    end

    it 'it unique within schools' do

    end

    it 'is >= 4 characters' do

    end

    it 'is <= 50 characters' do

    end
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: schools
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe School, type: :model do
  let(:school) { build(:school, name: 'NU')}

  context 'validations' do
    before do
      expect(school).to be_valid
    end
    describe 'name' do
      it 'is no longer than 20 characters' do
        school.name = 'A'*20
        expect(school).to be_valid

        school.name = 'A'*21
        expect(school).not_to be_valid
      end

      it 'is unique' do
        create(:school, name: school.name)
        expect(school).not_to be_valid
      end
    end
  end
end

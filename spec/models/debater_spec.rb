# frozen_string_literal: true

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
  let(:school)  { create(:school) }
  let(:debater) { build(:debater, name: 'John Doe', school: school, novice: false) }

  context 'validations' do
    before do
      expect(debater).to be_valid
    end

    describe 'name' do
      it 'is present' do
        debater.name = '  '
        expect(debater).not_to be_valid

        debater.name = nil
        expect(debater).not_to be_valid
      end

      it 'it unique within schools' do
        new_school = create(:school)
        random_debater = create(:debater, school: new_school)
        debater.name = random_debater.name
        expect(debater).to be_valid

        random_debater = create(:debater, school: school)
        debater.name = random_debater.name
        expect(debater).not_to be_valid
      end

      it 'is >= 4 characters' do
        debater.name = 'a' * 3
        expect(debater).not_to be_valid

        debater.name = 'a' * 4
        expect(debater).to be_valid
      end

      it 'is < 50 characters' do
        debater.name = 'a' * 50
        expect(debater).not_to be_valid

        debater.name = 'a' * 49
        expect(debater).to be_valid
      end
    end

    describe 'school' do
      it 'is present' do
        debater.school = nil
        expect(debater).not_to be_valid
      end
    end
  end
end

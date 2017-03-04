# frozen_string_literal: true

# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  seed       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:team) { build(:team, name: 'Team Name', seed: :unseeded) }

  context 'validations' do
    describe 'name' do
      it 'is present' do
        team.name = '  '
        expect(team).not_to be_valid

        team.name = nil
        expect(team).not_to be_valid
      end

      it 'is unique' do
        create(:team, name: team.name)
        expect(team).not_to be_valid
      end

      it 'is >= 4 characters' do
        team.name = 'a' * 3
        expect(team).not_to be_valid

        team.name = 'a' * 4
        expect(team).to be_valid
      end

      it 'is < 50 characters' do
        team.name = 'a' * 50
        expect(team).not_to be_valid

        team.name = 'a' * 49
        expect(team).to be_valid
      end
    end

    # TODO force teams to have two debaters
  end
end

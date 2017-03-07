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
#  school_id  :integer
#

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Team, type: :model do
  context 'validations' do
    let(:school) { create(:school) }
    let(:team) do
      build(:team, name: 'Team Name', seed: :unseeded, school: school,
                   debaters: create_list(:debater, 2, school: school))
    end

    before do
      expect(team).to be_valid
    end

    describe 'name' do
      it 'is present' do
        team.name = '  '
        expect(team).not_to be_valid

        team.name = nil
        expect(team).not_to be_valid
      end

      it 'is unique' do
        create(:team_with_debaters, name: team.name)
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

    describe 'school' do
      it 'is present' do
        team.school = nil
        expect(team).not_to be_valid
      end

      it 'must be the school of one of the debaters on the team' do
        team.debaters = create_list(:debater, 2, school: create(:school))
        expect(team).not_to be_valid

        team.debaters = [create(:debater), create(:debater, school: school)]
        expect(team).to be_valid
      end
    end

    describe 'debaters' do
      it 'has 2 debaters' do
        team.debaters = create_list(:debater, 1)
        expect(team).not_to be_valid

        team.debaters = []
        expect(team).not_to be_valid

        team.debaters = create_list(:debater, 3)
        expect(team).not_to be_valid
      end
    end
  end

  describe '#opponents' do
    let(:team)      { create(:team_with_debaters) }
    let(:opponents) { create_list(:team_with_debaters, 5) }

    before do
      opponents.each_with_index do |opponent, i|
        if i.even?
          create(:round, gov_team: team, opp_team: opponent, round_number: i)
        else
          create(:round, gov_team: opponent, opp_team: team, round_number: i)
        end
      end
    end

    it 'returns all of the teams that a team has been in round with' do
      expect(team.opponents).to match_array(opponents)
    end
  end
end

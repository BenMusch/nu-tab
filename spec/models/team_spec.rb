# frozen_string_literal: true
# == Schema Information
#
# Table name: teams
#
#  id           :integer          not null, primary key
#  name         :string
#  seed         :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  school_id    :integer
#  hit_pull_up  :boolean          default("false")
#  been_pull_up :boolean          default("false")
#

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:team) { create(:team_with_debaters) }

  describe 'validations' do
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

  describe '#govs' do
    it 'returns the rounds a team has been the gov team' do
      govs = create_round_list(2, gov_team: team, opp_team: create(:team_with_debaters))
      create_round_list(2, 2, gov_team: create(:team_with_debaters), opp_team: team)

      expect(team.govs.to_a).to match_array govs
    end
  end

  describe '#opps' do
    it 'returns the rounds a team has been the gov team' do
      create_round_list(2, gov_team: team, opp_team: create(:team_with_debaters))
      opps = create_round_list(2, 2, gov_team: create(:team_with_debaters), opp_team: team)

      expect(team.opps.to_a).to match_array opps
    end
  end

  describe '#hit?' do
    it 'returns whether or not the team has hit the other team' do
      opponent1 = create(:team_with_debaters)
      opponent2 = create(:team_with_debaters)
      create(:round, gov_team: team, opp_team: opponent1, round_number: 1)
      create(:round, gov_team: opponent2, opp_team: team, round_number: 2)

      team.reload
      expect(team.hit?(opponent1)).to be true
      expect(team.hit?(opponent2)).to be true
      expect(team.hit?(create(:team_with_debaters))).to be false
    end
  end

  describe '#gotten_bye?' do
    it 'returns whether or not the team has gotten a bye' do
      create(:round, gov_team: team, opp_team: create(:team_with_debaters), round_number: 1)
      create(:round, gov_team: create(:team_with_debaters), opp_team: team, round_number: 2)

      team.reload
      expect(team.gotten_bye?).to be false

      create(:bye, team: team, round_number: 3)

      team.reload
      expect(team.gotten_bye?).to be true
    end
  end

  describe '#had_rounds?' do
    context 'with byes' do
      before do
        create(:bye, team: team)
      end

      it 'is true' do
        expect(team.reload.had_rounds?).to be true
      end
    end

    context 'with rounds' do
      before do
        create(:round, gov_team: team, opp_team: create(:team_with_debaters))
      end

      it 'is true' do
        expect(team.reload.had_rounds?).to be true
      end
    end

    context 'without rounds or byes' do
      it 'is false' do
        expect(team.reload.had_rounds?).to be false
      end
    end
  end

  describe '#seed_int' do
    context 'unseeded' do
      it 'is 3' do
        expect(create(:team_with_debaters, seed: :unseeded).seed_int).to be 3
      end
    end

    context 'free seeds' do
      it 'is 2' do
        expect(create(:team_with_debaters, seed: :free_seed).seed_int).to be 2
      end
    end

    context 'half seeds' do
      it 'is 1' do
        expect(create(:team_with_debaters, seed: :half_seed).seed_int).to be 1
      end
    end

    context 'full seeds' do
      it 'is 0' do
        expect(create(:team_with_debaters, seed: :full_seed).seed_int).to be 0
      end
    end
  end
end

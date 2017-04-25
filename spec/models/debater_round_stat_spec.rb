# frozen_string_literal: true

# == Schema Information
#
# Table name: debater_round_stats
#
#  id         :integer          not null, primary key
#  debater_id :integer
#  round_id   :integer
#  speaks     :float
#  ranks      :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe DebaterRoundStat, type: :model do
  context 'validations' do
    let(:school)        { create(:school) }
    let(:gov)           { create(:team, debaters: [gov_debater, create(:debater)], school: school) }
    let(:opp)           { create(:team, debaters: [opp_debater, create(:debater)], school: school) }
    let(:gov_debater)   { create(:debater, school: school) }
    let(:opp_debater)   { create(:debater, school: school) }
    let(:other_debater) { create(:team_with_debaters).debaters.first }
    let(:round)         { create(:round, gov_team: gov, opp_team: opp) }
    let(:debater)       { create(:debater) }
    let(:stats) do
      build(:debater_round_stat, round: round, debater: gov_debater, speaks: 25,
                                 ranks: 1,     position: :pm)
    end

    before do
      expect(stats).to be_valid
    end

    it 'validates debaters to be a member of the team their position indicates' do
      stats.position = :lo
      expect(stats).not_to be_valid
    end

    it 'forces the debater to be a member of one of the teams' do
      stats.debater = other_debater
      expect(stats).not_to be_valid

      stats.position = :lo
      expect(stats).not_to be_valid
    end

    describe 'speaks' do
      it 'is present' do
        stats.speaks = nil
        expect(stats).not_to be_valid
      end
    end

    describe 'ranks' do
      it 'is present' do
        stats.ranks = nil
        expect(stats).not_to be_valid
      end

      it 'is 1, 2, 3 or 4' do
        stats.ranks = 0
        expect(stats).not_to be_valid

        stats.ranks = 1
        expect(stats).to be_valid

        stats.ranks = 2
        expect(stats).to be_valid

        stats.ranks = 3
        expect(stats).to be_valid

        stats.ranks = 4
        expect(stats).to be_valid

        stats.ranks = 5
        expect(stats).not_to be_valid
      end

      it 'is unique within the round' do
        create(:debater_round_stat, round: round, debater: opp_debater,
                                    position: :lo, ranks: stats.ranks)
        expect(stats).not_to be_valid
      end
    end

    describe 'position' do
      it 'is present' do
        stats.position = nil
        expect(stats).not_to be_valid
      end

      it 'is unique within the round' do
        other_gov_debater = create(:debater, team: gov)
        create(:debater_round_stat, round: round, debater: other_gov_debater,
                                    ranks: 2, position: stats.position)
        expect(stats).not_to be_valid
      end
    end
  end
end

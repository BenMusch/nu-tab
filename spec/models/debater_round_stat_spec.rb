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
    let(:gov)           { create(:team) }
    let(:opp)           { create(:team) }
    let(:gov_debater)   { create(:debater, team: gov) }
    let(:opp_debater)   { create(:debater, team: opp) }
    let(:other_debater) { create(:debater, team: create(:team)) }
    let(:round)         { create(:round, gov_team: gov, opp_team: opp) }
    let(:debater)       { create(:debater) }
    let(:stats) do
      build(:debater_round_stat, round: round, debater: gov_debater, speaks: 25,
                                 ranks: 1,     position: :pm)
    end

    before do
      expect(stats).to be_valid
    end

    describe 'speaks' do
      it 'is present' do
        stats.speaks = nil
        expect(stats).not_to be_valid
      end

      it 'is >= 22' do
        stats.speaks = 21.99
        expect(stats).not_to be_valid

        stats.speaks = 22
        expect(stats).to be_valid
      end

      it 'is <= 28' do
        stats.speaks = 28.01
        expect(stats).not_to be_valid

        stats.speaks = 28
        expect(stats).to be_valid
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

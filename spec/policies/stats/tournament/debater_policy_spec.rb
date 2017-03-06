# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Stats::Tournament::DebaterPolicy do
  let(:team)    { create(:team_with_debaters) }
  let(:debater) { team.debaters.first }
  let(:stats)   { described_class.new(debater) }
  let(:speaks)  { [2, 1, 3, 5, 4] }
  let(:ranks)   { [1, 2, 3, 4, 1] }

  before do
    allow(Stats::Round).to receive(:policy_for).and_return(nil)
    speaks.size.times do |i|
      round_num = i + 1
      round = create(:round, gov_team: team, opp_team: create(:team_with_debaters),
                             round_number: round_num)
      allow(Stats::Round).to receive(:policy_for).with(debater, round).
        and_return(double("round#{round_num}_stats", speaks: speaks[i],
                                                     ranks: ranks[i]))
    end
  end

  describe '#speaks' do
    it 'adds the speaks of the policies for each round' do
      expect(stats.speaks).to eq 1 + 2 + 3 + 4 + 5
    end
  end

  describe '#ranks' do
    it 'adds the ranks of the policies for each round' do
      expect(stats.ranks).to eq 1 + 2 + 3 + 4 + 1
    end
  end

  describe '#single_adjusted_speaks' do
    it 'adds the speaks, ignoring the min and max' do
      expect(stats.single_adjusted_speaks).to eq 2 + 3 + 4
    end
  end

  describe '#single_adjusted_ranks' do
    it 'adds the ranks, ignoring the min and max' do
      expect(stats.single_adjusted_ranks).to eq 1 + 2 + 3
    end
  end

  describe '#double_adjusted_speaks' do
    it 'adds the speaks, with the 2 max and 2 min ignored' do
      expect(stats.double_adjusted_speaks).to eq 3
    end
  end

  describe '#double_adjusted_ranks' do
    it 'adds the ranks, with the 2 max and 2 min ignored' do
      expect(stats.double_adjusted_ranks).to eq 2
    end
  end

  context 'without enough rounds for single/double adjust to have enough data' do
    before do
      Round.destroy_all
      round1 = create(:round, gov_team: team, opp_team: create(:team_with_debaters),
                              round_number: 1)
      round2 = create(:round, gov_team: team, opp_team: create(:team_with_debaters),
                              round_number: 2)
      allow(Stats::Round).to receive(:policy_for).with(debater, round1).
        and_return(double("round1_stats", speaks: 10, ranks: 1))
      allow(Stats::Round).to receive(:policy_for).with(debater, round2).
        and_return(double("round2_stats", speaks: 10, ranks: 1))
    end

    it 'returns 0' do
      expect(stats.single_adjusted_speaks).to be 0
      expect(stats.single_adjusted_ranks).to be 0
      expect(stats.double_adjusted_speaks).to be 0
      expect(stats.double_adjusted_ranks).to be 0
    end
  end
end

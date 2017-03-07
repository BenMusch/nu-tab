# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Stats::Tournament::TeamPolicy do
  let(:team)    { create(:team_with_debaters) }
  let(:stats)   { described_class.new(team) }
  let(:speaks)  { [2, 1, 3, 5, 4] }
  let(:ranks)   { [1, 2, 3, 4, 1] }

  before do
    allow(Stats::Round::TeamPolicy).to receive(:new).and_return(nil)
    # mock policies for each of the rounds
    #  - the speaks and ranks are the speaks and ranks in the array in the let
    #  bindings
    #  - win? is true for every even round (2 rounds out of 5)
    #  - win? is true for the opponent every odd round (3 out of 5)
    speaks.size.times do |i|
      round_num = i + 1
      opponent = create(:team_with_debaters)
      round = create(:round, gov_team: team, opp_team: opponent, round_number: round_num)
      allow(Stats::Round::TeamPolicy).to receive(:new).with(opponent, round).
        and_return(double(speaks: 0, ranks: 0, win?: round_num % 2 == 1))
      allow(Stats::Round::TeamPolicy).to receive(:new).with(team, round).
        and_return(double("round#{round_num}_stats", speaks: speaks[i],
                                                     ranks: ranks[i],
                                                     win?: round_num % 2 == 0))
    end
  end

  describe '#average_opponent_wins' do
    before do
      # give each opponent 1 win
      team.opponents.each do |opponent|
        round = create(:round, gov_team: opponent, opp_team: create(:team_with_debaters),
                               round_number: speaks.size + 1)
        allow(Stats::Round::TeamPolicy).to receive(:new).with(opponent, round).
          and_return(double(speaks: 0, ranks: 0, win?: true))
      end
    end

    it 'returns the number of wins the opponents have' do
      # each opponent has 1 win, every odd # opponent has an additional win
      expect(stats.average_opponent_wins).to eq 1.6
    end
  end

  describe '#wins' do
    it 'returns the number of round policies where win? is true' do
      expect(stats.wins).to be 2
    end
  end

  describe '#losses' do
    it 'returns the number of round policies where win? is true' do
      expect(stats.losses).to be 3
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
      allow(Stats::Round::TeamPolicy).to receive(:new).with(team, round1).
        and_return(double('round1_stats', speaks: 10, ranks: 1))
      allow(Stats::Round::TeamPolicy).to receive(:new).with(team, round2).
        and_return(double('round2_stats', speaks: 10, ranks: 1))
    end

    it 'returns 0' do
      expect(stats.single_adjusted_speaks).to be 0
      expect(stats.single_adjusted_ranks).to be 0
      expect(stats.double_adjusted_speaks).to be 0
      expect(stats.double_adjusted_ranks).to be 0
    end
  end
end

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Stats::Round::TeamPolicy do
  let(:debater1)            { team.debaters.first }
  let(:debater2)            { team.debaters.last }
  let(:team)                { create(:team_with_debaters) }
  let(:other_team)          { create(:team_with_debaters) }
  let(:round)               { create(:round, gov_team: team, opp_team: other_team) }
  let(:policy)              { described_class.new(team, round) }

  before do
    # force TeamPolicy to use a mock policy
    allow(Stats::Round).to receive(:policy_for).and_return(nil)
    allow(Stats::Round).to receive(:policy_for).with(debater1, round).
      and_return(double(speaks: 25.75, ranks: 2))
    allow(Stats::Round).to receive(:policy_for).with(debater2, round).
      and_return(double(speaks: 25, ranks: 1))
  end

  describe '#win?' do
    before do
      allow(round).to receive(:winner?).with(team).and_return(true)
      allow(round).to receive(:winner?).with(other_team).and_return(false)
    end

    it 'returns the value based on the rounds #winner? method' do
      expect(policy.win?).to be true
      expect(described_class.new(other_team, round).win?).to be false
    end
  end

  describe '#speaks' do
    it 'adds the speaks from the debater policy' do
      expect(policy.speaks).to eq 50.75
    end
  end

  describe '#ranks' do
    it 'adds the speaks from the debater policy' do
      expect(policy.ranks).to eq 3
    end
  end

  context 'with an iron person' do
    before do
      # ignore the ranks, the team policy should just use the mocked policies
      create(:debater_round_stat, round: round, debater: debater1, position: :pm, ranks: 2)
      create(:debater_round_stat, round: round, debater: debater1, position: :mg, ranks: 1)
    end

    it 'uses the stats from the iron person both times' do
      expect(policy.speaks).to eq 51.5
      expect(policy.ranks).to eq 4
    end
  end
end

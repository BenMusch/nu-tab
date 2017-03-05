# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Stats::Round::TeamPolicy do
  let(:debater1)            { team.debaters.first }
  let(:debater2)            { team.debaters.last }
  let(:team)                { create(:team_with_debaters) }
  let(:round)               { create(:round, gov_team: team, opp_team: create(:team_with_debaters)) }
  let(:policy)              { described_class.new(team, round) }

  before do
    # force TeamPolicy to use a mock policy
    allow(Stats::Round).to receive(:policy_for).and_return(nil)
    allow(Stats::Round).to receive(:policy_for).with(debater1, round)
      .and_return(double(speaks: 25.75, ranks: 2))
    allow(Stats::Round).to receive(:policy_for).with(debater2, round)
      .and_return(double(speaks: 25, ranks: 1))
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
end
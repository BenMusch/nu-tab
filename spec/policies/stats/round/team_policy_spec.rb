# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Stats::Round::TeamPolicy do
  let(:debater1)            { team.debaters.first }
  let(:debater2)            { team.debaters.last }
  let(:team)                { create(:team_with_debaters) }
  let(:round)               { create(:round, gov_team: team, opp_team: create(:team_with_debaters)) }
  let(:mock_debater_policy) { double }
  let(:policy)              { described_class.new(team, round, debater_policy: mock_debater_policy) }

  before do
    allow(mock_debater_policy).to receive(:new).and_return(nil)
    allow(mock_debater_policy).to receive(:new).with(debater1, round).
      and_return(double(speaks: 25, ranks: 1))
    allow(mock_debater_policy).to receive(:new).with(debater2, round).
      and_return(double(speaks: 25.75, ranks: 2))
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

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Stats::Round::StandardPolicy do
  let(:team)       { create(:team) }
  let(:other_team) { create(:team) }
  let(:debater)    { create(:debater, team: team) }
  let(:round)      { create(:round, gov_team: team, opp_team: other_team) }
  let(:policy)     { described_class.new(debater, round) }
  let!(:stats) do
    create(:debater_round_stat, round: round, debater: debater, speaks: 25.5, ranks: 3)
  end

  before do
    create(:debater, team: team)
    2.times { create(:debater, team: other_team) }
  end

  describe '#speaks' do
    it "returns the speaks of the debater's stats for the round" do
      expect(policy.speaks).to eq stats.speaks
    end
  end

  describe '#ranks' do
    it "returns the ranks of the debater's stats for the round" do
      expect(policy.ranks).to eq stats.ranks
    end
  end
end

RSpec.describe Stats::Round::PunitivePolicy do
  let(:team)       { create(:team) }
  let(:other_team) { create(:team) }
  let(:debater)    { create(:debater, team: team) }
  let(:round)      { create(:round, gov_team: team, opp_team: other_team) }
  let(:policy)     { described_class.new(debater, round) }

  describe '#speaks' do
    it "returns the speaks of the debater's stats for the round" do
      expect(policy.speaks).to eq TournamentSetting.get('min_speaks')
    end
  end

  describe '#ranks' do
    it "returns the ranks of the debater's stats for the round" do
      expect(policy.ranks).to eq 3.5
    end
  end
end

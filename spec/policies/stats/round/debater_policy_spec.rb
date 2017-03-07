# frozen_string_literal: true
require 'rails_helper'

RSpec.shared_context 'it has a full round' do
  let(:team)       { create(:team_with_debaters) }
  let(:other_team) { create(:team_with_debaters) }
  let(:debater)    { create(:debater, team: team) }
  let(:round)      { create(:round, gov_team: team, opp_team: other_team, round_number: 2) }
end

RSpec.describe Stats::Round::StandardPolicy do
  include_context 'it has a full round'
  let(:policy) { described_class.new(debater, round) }
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
  include_context 'it has a full round'
  let(:policy) { described_class.new(debater, round) }

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

RSpec.describe Stats::Round::IronPersonPolicy do
  include_context 'it has a full round'
  let(:policy) { described_class.new(debater, round) }

  before do
    create(:debater_round_stat, round: round, debater: debater, speaks: 25.5,
                                ranks: 3, position: :mg)
    create(:debater_round_stat, round: round, debater: debater, speaks: 25.75,
                                ranks: 2, position: :pm)
  end

  describe '#speaks' do
    it 'averages the two speaks' do
      expect(policy.speaks).to eq 25.625
    end
  end

  describe '#ranks' do
    it 'averages the two ranks' do
      expect(policy.ranks).to eq 2.5
    end
  end
end

RSpec.describe Stats::Round::AverageStatsPolicy do
  include_context 'it has a full round'
  let(:policy) { described_class.new(debater, round) }

  before do
    debater = create(:team_with_debaters).debaters.first
    round = create(:round, gov_team: debater.team, opp_team: create(:team_with_debaters), round_number: rand(5))
    create(:debater_round_stat, round: round, debater: debater, speaks: 26, ranks: 3)

    debater = create(:team_with_debaters).debaters.first
    round = create(:round, gov_team: debater.team, opp_team: create(:team_with_debaters), round_number: rand(5))
    create(:debater_round_stat, round: round, debater: debater, speaks: 26.25, ranks: 4)
  end

  context 'with other round stats in the database' do
    let(:round1) { create(:round, gov_team: team, opp_team: create(:team_with_debaters), round_number: 1) }
    let(:round3) { create(:round, gov_team: team, opp_team: create(:team_with_debaters), round_number: 3) }
    let!(:round1_stats) do
      create(:debater_round_stat, round: round1, debater: debater, speaks: 25, ranks: 1)
    end
    let!(:round2_stats) do
      create(:debater_round_stat, round: round3, debater: debater, speaks: 25.25, ranks: 2)
    end

    describe '#speaks' do
      it 'averages all of the speaks for the debater' do
        expect(policy.speaks).to eq 25.125
      end
    end

    describe '#ranks' do
      it 'averages all of the ranks for the debater' do
        expect(policy.ranks).to eq 1.5
      end
    end
  end

  context 'without other round stats in the database' do
    describe '#speaks' do
      it 'averages speaks for all of the debaters' do
        expect(policy.speaks).to eq 26.125
      end
    end

    describe '#ranks' do
      it 'averages ranks for all of the debaters' do
        expect(policy.ranks).to eq 3.5
      end
    end
  end
end

RSpec.describe Stats::Round::BlankPolicy do
  include_context 'it has a full round'
  let(:policy) { described_class.new(debater, round) }

  describe '#speaks' do
    it 'returns 0' do
      expect(policy.speaks).to eq 0
    end
  end

  describe '#ranks' do
    it 'averages the two ranks' do
      expect(policy.ranks).to eq 0
    end
  end
end

# frozen_string_literal: true
require 'rails_helper'

RSpec.shared_context 'with a punitive forfeit policy' do
  before do
    TournamentSetting.set('punish_forfeits', 1)
  end

  after do
    TournamentSetting.set('punish_forfeits', false)
  end
end

RSpec.describe Stats::Round do
  let(:policy_class) { Stats::Round.policy_for(team, round) }
  let(:team)         { create(:team) }
  let(:round)        { create(:round, gov_team: team, opp_team: create(:team)) }

  describe '#policy_for' do
    context 'when the round is a bye' do
      let(:round) { create(:bye, team: team) }

      it 'returns an AverageStatsPolicy' do
        expect(policy_class).to be Stats::Round::AverageStatsPolicy
      end
    end

    context 'when the round it a gov win or gov' do
      it 'returns a StandardPolicy' do
        round.result = :gov_win
        expect(policy_class).to be Stats::Round::StandardPolicy

        round.result = :opp_win
        expect(policy_class).to be Stats::Round::StandardPolicy
      end
    end

    context 'when the round is a forfeit that the team won' do
      it 'returns an AverageStatsPolicy' do
        round.result = :opp_forfeit
        expect(policy_class).to be Stats::Round::AverageStatsPolicy
      end
    end

    context 'when the round was forfeited by the team' do
      before do
        round.result = :gov_forfeit
      end

      context 'with a punitive forfeit policy' do
        include_context 'with a punitive forfeit policy'

        it 'returns a PunitivePolicy' do
          expect(policy_class).to be Stats::Round::PunitivePolicy
        end
      end

      context 'with a lenient forfeit policy' do
        it 'returns an AverageStatsPolicy' do
          expect(policy_class).to be Stats::Round::AverageStatsPolicy
        end
      end
    end

    context 'when the round was an all win' do
      it 'returns an AverageStatsPolicy' do
        round.result = :all_win
        expect(policy_class).to be Stats::Round::AverageStatsPolicy
      end
    end

    context 'when the round was an all drop' do
      before do
        round.result = :all_drop
      end

      context 'with a punitive forfeit policy' do
        include_context 'with a punitive forfeit policy'

        it 'returns a PunitivePolicy' do
          expect(policy_class).to be Stats::Round::PunitivePolicy
        end
      end

      context 'with a lenient forfeit policy' do
        it 'returns an AverageStatsPolicy' do
          expect(policy_class).to be Stats::Round::AverageStatsPolicy
        end
      end
    end
  end
end

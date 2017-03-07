# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Stats::Round do
  let(:policy_class) { Stats::Round.policy_for(debater, round) }
  let(:team)         { create(:team_with_debaters) }
  let(:debater)      { team.debaters.first }
  let(:round)        { create(:round, gov_team: team, opp_team: create(:team_with_debaters)) }

  describe '#policy_for' do
    context 'when the round is a bye' do
      let(:round) { create(:bye, team: team) }

      it 'returns an AverageStatsPolicy' do
        expect(policy_class).to eq Stats::Round::AverageStatsPolicy.new debater, round
      end
    end

    context 'when the round it a gov win or gov' do
      before do
        ranks = [1, 2, 3, 4]
        round.teams.each do |team|
          positions = round.gov_team == team ? [:mg, :pm] : [:lo, :mo]
          team.debaters.each do |debater|
            create(:debater_round_stat, round: round, debater: debater, speaks: 25,
                                        ranks: ranks.pop, position: positions.pop)
          end
        end
      end

      context 'when the round is an iron person round' do
        before do
          pm = round.debater_round_stats.pm.debater
          mg_stats = round.debater_round_stats.mg
          mg_stats.debater = pm
          mg_stats.save!
        end

        before(:each) do
          round.reload
          round.result = :gov_win
        end

        context 'for the non-competing debater' do
          context 'with a punitive forfeit policy' do
            include_context 'with a punitive forfeit policy'

            it 'returns a PunitivePolicy' do
              expect(policy_class).to eq Stats::Round::PunitivePolicy.new debater, round
            end
          end

          context 'with a lenient forfeit policy' do
            it 'returns an AverageStatsPolicy' do
              expect(policy_class).to eq Stats::Round::AverageStatsPolicy.new debater, round
            end
          end
        end

        context 'for the competing debater' do
          it 'returns an IronPersonPolicy' do
            expect(policy_class).to eq Stats::Round::IronPersonPolicy.new debater, round
          end
        end
      end

      it 'returns a StandardPolicy' do
        round.reload
        round.result = :gov_win
        expect(policy_class).to eq Stats::Round::StandardPolicy.new debater, round

        round.result = :opp_win
        expect(policy_class).to eq Stats::Round::StandardPolicy.new debater, round
      end
    end

    context 'when no result is entered' do
      it 'returns a blank policy' do
        expect(policy_class).to eq Stats::Round::BlankPolicy.new debater, round
      end
    end

    context 'when the round is a forfeit that the team won' do
      it 'returns an AverageStatsPolicy' do
        round.result = :opp_forfeit
        expect(policy_class).to eq Stats::Round::AverageStatsPolicy.new debater, round
      end
    end

    context 'when the round was forfeited by the team' do
      before do
        round.result = :gov_forfeit
      end

      context 'with a punitive forfeit policy' do
        include_context 'with a punitive forfeit policy'

        it 'returns a PunitivePolicy' do
          expect(policy_class).to eq Stats::Round::PunitivePolicy.new debater, round
        end
      end

      context 'with a lenient forfeit policy' do
        it 'returns an AverageStatsPolicy' do
          expect(policy_class).to eq Stats::Round::AverageStatsPolicy.new debater, round
        end
      end
    end

    context 'when the round was an all win' do
      it 'returns an AverageStatsPolicy' do
        round.result = :all_win
        expect(policy_class).to eq Stats::Round::AverageStatsPolicy.new debater, round
      end
    end

    context 'when the round was an all drop' do
      before do
        round.result = :all_drop
      end

      context 'with a punitive forfeit policy' do
        include_context 'with a punitive forfeit policy'

        it 'returns a PunitivePolicy' do
          expect(policy_class).to eq Stats::Round::PunitivePolicy.new debater, round
        end
      end

      context 'with a lenient forfeit policy' do
        it 'returns an AverageStatsPolicy' do
          expect(policy_class).to eq Stats::Round::AverageStatsPolicy.new debater, round
        end
      end
    end
  end
end

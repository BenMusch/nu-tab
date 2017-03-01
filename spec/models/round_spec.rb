# == Schema Information
#
# Table name: rounds
#
#  id           :integer          not null, primary key
#  result       :integer
#  room_id      :integer
#  gov_team_id  :integer
#  opp_team_id  :integer
#  round_number :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Round, type: :model do
  context 'validations' do
    let(:gov) { create(:team) }
    let(:opp) { create(:team) }
    let(:pm)  { create(:debater) }
    let(:mg)  { create(:debater) }
    let(:lo)  { create(:debater) }
    let(:mo)  { create(:debater) }
    let(:round) { create(:round, gov_team: gov, opp_team: opp) }

    before do
      create(:debater_team, team: opp, debater: lo)
      create(:debater_team, team: opp, debater: mo)
      create(:debater_team, team: gov, debater: pm)
      create(:debater_team, team: gov, debater: mg)
    end

    context 'when result is present' do
      context 'when result is a gov_win or opp_win' do
        it 'has to have two full teams' do
          round.result = :gov_win
          expect(round).not_to be_valid

          create(:debater_round_stat, debater: pm, ranks: 1, position: :pm, round: round)
          round.reload
          round.result = :gov_win
          expect(round).not_to be_valid

          create(:debater_round_stat, debater: mg, ranks: 2, position: :mg, round: round)
          round.reload
          round.result = :gov_win
          expect(round).not_to be_valid

          create(:debater_round_stat, debater: lo, ranks: 3, position: :lo, round: round)
          round.reload
          round.result = :gov_win
          expect(round).not_to be_valid

          create(:debater_round_stat, debater: mo, ranks: 4, position: :mo, round: round)
          round.reload
          round.result = :gov_win
          expect(round).to be_valid
        end

        it 'has to have ranks that correspond to the speaks' do
        end

        it "can't have low-speak wins" do
          # low-speak win
          create(:debater_round_stat, debater: pm, ranks: 2, speaks: 26.25, position: :pm, round: round)
          create(:debater_round_stat, debater: mg, ranks: 3, speaks: 26, position: :mg, round: round)
          create(:debater_round_stat, debater: lo, ranks: 1, speaks: 26.5, position: :lo, round: round)
          create(:debater_round_stat, debater: mo, ranks: 4, speaks: 25.5, position: :mo, round: round)
          round.reload
          round.result = :opp_win
          expect(round).not_to be_valid
          round.debater_round_stats.destroy_all

          # equal-speak win
          create(:debater_round_stat, debater: pm, ranks: 2, speaks: 26, position: :pm, round: round)
          create(:debater_round_stat, debater: mg, ranks: 3, speaks: 26, position: :mg, round: round)
          create(:debater_round_stat, debater: lo, ranks: 1, speaks: 26.5, position: :lo, round: round)
          create(:debater_round_stat, debater: mo, ranks: 4, speaks: 25.5, position: :mo, round: round)
          round.reload
          round.result = :opp_win
          expect(round).to be_valid
          round.debater_round_stats.destroy_all

          # high-speak win
          create(:debater_round_stat, debater: pm, ranks: 2, speaks: 26, position: :pm, round: round)
          create(:debater_round_stat, debater: mg, ranks: 3, speaks: 26, position: :mg, round: round)
          create(:debater_round_stat, debater: lo, ranks: 1, speaks: 26.5, position: :lo, round: round)
          create(:debater_round_stat, debater: mo, ranks: 4, speaks: 25.75, position: :mo, round: round)
          round.reload
          round.result = :opp_win
          expect(round).to be_valid
          round.debater_round_stats.destroy_all
        end

        it "can't have low-rank wins" do
          # low-rank win
          create(:debater_round_stat, debater: pm, ranks: 2, position: :pm, round: round)
          create(:debater_round_stat, debater: mg, ranks: 4, position: :mg, round: round)
          create(:debater_round_stat, debater: lo, ranks: 1, position: :lo, round: round)
          create(:debater_round_stat, debater: mo, ranks: 3, position: :mo, round: round)
          round.reload
          round.result = :gov_win
          expect(round).not_to be_valid
          round.debater_round_stats.destroy_all

          # equal-rank win
          create(:debater_round_stat, debater: pm, ranks: 2, position: :pm, round: round)
          create(:debater_round_stat, debater: mg, ranks: 3, position: :mg, round: round)
          create(:debater_round_stat, debater: lo, ranks: 1, position: :lo, round: round)
          create(:debater_round_stat, debater: mo, ranks: 4, position: :mo, round: round)
          round.reload
          round.result = :gov_win
          expect(round).to be_valid
          round.debater_round_stats.destroy_all

          # high-rank win
          create(:debater_round_stat, debater: pm, ranks: 1, position: :pm, round: round)
          create(:debater_round_stat, debater: mg, ranks: 2, position: :mg, round: round)
          create(:debater_round_stat, debater: lo, ranks: 3, position: :lo, round: round)
          create(:debater_round_stat, debater: mo, ranks: 4, position: :mo, round: round)
          round.reload
          round.result = :gov_win
          expect(round).to be_valid
        end
      end
    end
  end
end

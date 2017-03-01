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
      end
    end
  end
end

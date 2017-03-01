# frozen_string_literal: true

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
    let(:gov)   { create(:team) }
    let(:opp)   { create(:team) }
    let(:pm)    { create(:debater) }
    let(:mg)    { create(:debater) }
    let(:lo)    { create(:debater) }
    let(:mo)    { create(:debater) }
    let(:room)  { create(:room) }
    let(:round) { create(:round, gov_team: gov, opp_team: opp, room: room, round_number: 1) }

    before do
      create(:debater_team, team: opp, debater: lo)
      create(:debater_team, team: opp, debater: mo)
      create(:debater_team, team: gov, debater: pm)
      create(:debater_team, team: gov, debater: mg)
    end

    it 'has a gov_team' do
      round.gov_team = nil
      expect(round).not_to be_valid
    end

    it 'has an opp team' do
      round.opp_team = nil
      expect(round).not_to be_valid
    end

    it 'has a room' do
      round.room = nil
      expect(round).not_to be_valid
    end

    it 'has a round number' do
      round.round_number = nil
      expect(round).not_to be_valid
    end

    it "can't have the same gov_team and opp_team" do
      round.opp_team = gov
      expect(round).not_to be_valid
    end

    it "can't have teams that are already paired in to the same round number" do
      other_round = build(:round, gov_team: gov, opp_team: create(:team),
                                  round_number: round.round_number, room: create(:room))
      expect(other_round).not_to be_valid
      other_round.round_number = round.round_number + 1
      expect(other_round).to be_valid

      other_round = build(:round, gov_team: create(:team), opp_team: gov,
                                  round_number: round.round_number, room: create(:room))
      expect(other_round).not_to be_valid
      other_round.round_number = round.round_number + 1
      expect(other_round).to be_valid

      other_round = build(:round, gov_team: opp, opp_team: create(:team),
                                  round_number: round.round_number, room: create(:room))
      expect(other_round).not_to be_valid
      other_round.round_number = round.round_number + 1
      expect(other_round).to be_valid

      other_round = build(:round, gov_team: create(:team), opp_team: opp,
                                  round_number: round.round_number, room: create(:room))
      expect(other_round).not_to be_valid
      other_round.round_number = round.round_number + 1
      expect(other_round).to be_valid

      other_round = build(:round, gov_team: gov, opp_team: opp,
                                  round_number: round.round_number, room: create(:room))
      expect(other_round).not_to be_valid
      other_round.round_number = round.round_number + 1
      expect(other_round).to be_valid

      other_round = build(:round, gov_team: opp, opp_team: gov,
                                  round_number: round.round_number, room: create(:room))
      expect(other_round).not_to be_valid
      other_round.round_number = round.round_number + 1
      expect(other_round).to be_valid
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

        it "can't have ranks and speaks out of order" do
          create(:debater_round_stat, debater: pm, ranks: 1, position: :pm, speaks: 26, round: round)
          create(:debater_round_stat, debater: mg, ranks: 2, position: :mg, speaks: 26.5, round: round)
          create(:debater_round_stat, debater: lo, ranks: 3, position: :lo, speaks: 26, round: round)
          create(:debater_round_stat, debater: mo, ranks: 4, position: :mo, speaks: 25.5, round: round)
          round.reload
          round.result = :gov_win
          expect(round).not_to be_valid
          round.debater_round_stats.destroy_all

          create(:debater_round_stat, debater: pm, ranks: 1, position: :pm, speaks: 26.5, round: round)
          create(:debater_round_stat, debater: mg, ranks: 2, position: :mg, speaks: 26, round: round)
          create(:debater_round_stat, debater: lo, ranks: 3, position: :lo, speaks: 26, round: round)
          create(:debater_round_stat, debater: mo, ranks: 4, position: :mo, speaks: 25.5, round: round)
          round.reload
          round.result = :gov_win
          expect(round).to be_valid
          round.debater_round_stats.destroy_all
        end
      end

      context 'when the results is anything other than a gov or opp win' do
        let(:result_types) { [:gov_forfeit, :opp_forfeit, :all_drop, :all_win] }

        it "can't have round stats" do
          result_types.each do |result_type|
            round.result = result_type
            expect(round).to be_valid
          end

          result_types.each do |result_type|
            create(:debater_round_stat, debater: pm, position: :pm, round: round)
            round.reload
            round.result = result_type
            expect(round).not_to be_valid
            round.debater_round_stats.destroy_all
          end
        end
      end
    end
  end
end

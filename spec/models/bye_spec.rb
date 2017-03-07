# frozen_string_literal: true

# == Schema Information
#
# Table name: byes
#
#  id           :integer          not null, primary key
#  team_id      :integer
#  round_number :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Bye, type: :model do
  let(:bye) { build(:bye, team: create(:team_with_debaters), round_number: 1) }

  context 'validations' do
    before do
      expect(bye).to be_valid
    end

    describe 'team' do
      it 'is present' do
        bye.team = nil
        expect(bye).not_to be_valid
      end

      it 'is not paired into this round' do
        round = create(:round, gov_team: create(:team_with_debaters), opp_team: bye.team, round_number: 1)
        expect(bye).not_to be_valid
        round.destroy

        create(:bye, team: bye.team, round_number: 1)
        expect(bye).not_to be_valid
      end
    end
  end

  describe 'winner?' do
    it 'returns true' do
      expect(bye.winner?(bye.team)).to be true
    end
  end
end

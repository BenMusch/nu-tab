# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckInnable do
  let(:model_types) { [:judge, :room, :team_with_debaters] }
  let(:model)       { create(model_types.sample) }

  describe '.checked_in' do
    let(:team)  { create(:team_with_debaters, id: 1) }
    let(:judge) { create(:judge, id: 1) }
    let(:room)  { create(:room, id: 1) }

    before do
      team.check_in_for_round!(1)
      room.check_in_for_round!(1)
      judge.check_in_for_round!(1)

      create(:judge)
      create(:team_with_debaters)
      create(:room)
    end

    it 'returns the models that checked in for that round' do
      expect(Team.checked_in(1).to_a).to match_array([team])
      expect(Judge.checked_in(1).to_a).to match_array([judge])
      expect(Room.checked_in(1).to_a).to match_array([room])

      expect(Team.checked_in(2).to_a).to match_array([])
      expect(Judge.checked_in(2).to_a).to match_array([])
      expect(Room.checked_in(2).to_a).to match_array([])
    end
  end

  describe '#checked_in_for_round?' do
    it 'returns whether there is a check in for the given round number' do
      expect(model.checked_in_for_round?(1)).to be false
      create(:check_in, subject: model, round_number: 1)
      expect(model.checked_in_for_round?(1)).to be true
    end
  end

  describe '#check_in_for_round!' do
    it 'creates a check in for the subject in the given round number' do
      expect(model.checked_in_for_round?(1)).to be false
      model.check_in_for_round! 1
      expect(model.checked_in_for_round?(1)).to be true
    end
  end

  describe '#check_out_for_round!' do
    it 'removes all check ins for the subject in the given round number' do
      model.check_in_for_round! 1
      expect(model.checked_in_for_round?(1)).to be true

      model.check_out_for_round! 1
      expect(model.checked_in_for_round?(1)).to be false
    end
  end
end

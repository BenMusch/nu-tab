# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckInnable do
  let(:model_types) { [:judge, :room, :team] }
  let(:model)       { create(model_types.sample) }

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

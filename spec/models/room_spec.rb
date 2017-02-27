# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  name       :string
#  rank       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:room) { build(:room, name: 'Room 1', rank: 50) }

  context 'validations' do
    before do
      expect(room).to be_valid
    end

    describe 'name' do
      it 'is present' do
        room.name = '  '
        expect(room).not_to be_valid

        room.name = nil
        expect(room).not_to be_valid
      end

      it 'is unique' do
        create(:room, name: room.name)
        expect(room).not_to be_valid
      end

      it 'is >= 4 characters' do
        room.name = 'a' * 3
        expect(room).not_to be_valid

        room.name = 'a' * 4
        expect(room).to be_valid
      end

      it 'is < 50 characters' do
        room.name = 'a' * 50
        expect(room).not_to be_valid

        room.name = 'a' * 49
        expect(room).to be_valid
      end
    end
  end
end

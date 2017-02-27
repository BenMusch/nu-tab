# frozen_string_literal: true

# == Schema Information
#
# Table name: judges
#
#  id         :integer          not null, primary key
#  name       :string
#  rank       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Judge, type: :model do
  let(:judge) { build(:judge, name: 'John Doe', rank: 50) }

  context 'validations' do
    before do
      expect(judge).to be_valid
    end

    describe 'name' do
      it 'is present' do
        judge.name = '  '
        expect(judge).not_to be_valid

        judge.name = nil
        expect(judge).not_to be_valid
      end

      it 'is unique' do
        create(:judge, name: judge.name)
        expect(judge).not_to be_valid
      end

      it 'is >= 4 characters' do
        judge.name = 'a' * 3
        expect(judge).not_to be_valid

        judge.name = 'a' * 4
        expect(judge).to be_valid
      end

      it 'is < 50 characters' do
        judge.name = 'a' * 50
        expect(judge).not_to be_valid

        judge.name = 'a' * 49
        expect(judge).to be_valid
      end
    end
  end
end

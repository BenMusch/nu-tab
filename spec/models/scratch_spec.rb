# frozen_string_literal: true

# == Schema Information
#
# Table name: scratches
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  judge_id   :integer
#  type       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Scratch, type: :model do
  context 'validations' do
    it 'has a unique judge/team combination' do
      created_scratch = create(:scratch, judge: create(:judge), team: create(:team_with_debaters))
      expect(build(:scratch, judge: created_scratch.judge, team: created_scratch.team)).not_to be_valid
      expect(build(:scratch, judge: create(:judge), team: created_scratch.team)).to be_valid
      expect(build(:scratch, judge: created_scratch.judge, team: create(:team_with_debaters))).to be_valid
    end
  end
end

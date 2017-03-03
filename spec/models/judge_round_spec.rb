# frozen_string_literal: true

# == Schema Information
#
# Table name: judge_rounds
#
#  id         :integer          not null, primary key
#  chair      :boolean
#  round_id   :integer
#  judge_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe JudgeRound, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

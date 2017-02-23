# == Schema Information
#
# Table name: judge_schools
#
#  id         :integer          not null, primary key
#  judge_id   :integer
#  school_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe JudgeSchool, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

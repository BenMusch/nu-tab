# == Schema Information
#
# Table name: debaters
#
#  id         :integer          not null, primary key
#  name       :string
#  novice     :boolean
#  school_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Debater, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

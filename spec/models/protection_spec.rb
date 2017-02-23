# == Schema Information
#
# Table name: protections
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  school_id  :integer
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Protection, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

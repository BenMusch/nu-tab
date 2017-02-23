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
  pending "add some examples to (or delete) #{__FILE__}"
end

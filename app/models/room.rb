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
class Room < ApplicationRecord
end

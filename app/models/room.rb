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
  validates :rank, presence:     true,
                   greater_than: 0,
                   less_than:    100
  validates :name, presence:   true,
                   uniqueness: true,
                   length:     { is: 4...50 }
end

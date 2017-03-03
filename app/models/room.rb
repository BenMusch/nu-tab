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
  include CheckInnable

  validates :rank, presence:     true,
                   inclusion: 0...100
  validates :name, presence:   true,
                   uniqueness: true,
                   length:     { in: 4...50 }
end

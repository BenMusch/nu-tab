# frozen_string_literal: true

# Represents the individual competitors
#
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
class Debater < ApplicationRecord
  include CheckInnable

  belongs_to :school
  has_many :debater_teams
  has_one :team, through: :debater_teams

  validates :name, presence:   true,
                   length:     { in: 4...50 },
                   uniqueness: { scope: :school }
  validates :school, presence: true
end

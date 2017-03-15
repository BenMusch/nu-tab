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
#  team_id    :integer
#

class Debater < ApplicationRecord
  include Rankable

  belongs_to :school
  belongs_to :team
  has_many :debater_round_stats
  has_many :byes, through: :team

  validates :name, presence:   true,
                   length:     { in: 4...50 },
                   uniqueness: { scope: :school }
  validates :school, presence: true

  def stats
    @stats ||= Stats::Tournament::DebaterPolicy.new(self)
  end

  def rounds
    team.rounds
  end
end

# frozen_string_literal: true

# Represents a Team composed of two Debaters
#
# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  seed       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Team < ApplicationRecord
  has_many :scratches
  has_many :debaters
  has_many :judges, through: :scratches, as: :scratched_judges

  enum seed: [:full_seed, :half_seed, :free_seed, :unseeded]

  validates :name, presence: true, length: { in: 4...50 },
                   uniqueness: true

  def rounds
    Round.where(gov_team: self).or(Round.where(opp_team: self))
  end

  def member?(debater)
    debater.team == self
  end
end

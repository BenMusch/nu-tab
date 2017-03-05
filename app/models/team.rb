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
#  school_id  :integer
#

class Team < ApplicationRecord
  include CheckInnable

  belongs_to :school
  has_many :scratches
  has_many :debaters
  has_many :judges, through: :scratches, as: :scratched_judges

  enum seed: [:full_seed, :half_seed, :free_seed, :unseeded]

  validates :name, presence: true, length: { in: 4...50 },
                   uniqueness: true
  validates :school, presence: true

  validate do
    validate_team_size
    validate_school_membership
  end

  def rounds
    Round.where(gov_team: self).or(Round.where(opp_team: self))
  end

  def member?(debater)
    debater.team == self
  end

  private

  def validate_team_size
    errors.add(:base, 'Team must have two debaters') unless debaters.size == 2
  end

  def validate_school_membership
    same_school = debaters.map(&:school_id).include? school_id
    errors.add(:school, 'must be the school of one of the debaters') unless same_school
  end
end

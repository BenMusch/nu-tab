# frozen_string_literal: true

# Represents a Team composed of two Debaters
#
# == Schema Information
#
# Table name: teams
#
#  id           :integer          not null, primary key
#  name         :string
#  seed         :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  school_id    :integer
#  hit_pull_up  :boolean          default(FALSE)
#  been_pull_up :boolean          default(FALSE)
#

class Team < ApplicationRecord
  include CheckInnable
  include Rankable

  belongs_to :school
  has_many :scratches
  has_many :debaters
  has_many :judges, through: :scratches, as: :scratched_judges
  has_many :byes

  enum seed: [:full_seed, :half_seed, :free_seed, :unseeded]

  validates :name, presence: true, length: { in: 4...50 },
                   uniqueness: true
  validates :school, presence: true

  validate do
    validate_team_size
    validate_school_membership
  end

  def rounds
    opps.or(govs)
  end

  def member?(debater)
    debater.team == self
  end

  def opponents
    Team.where(id: rounds.select(:gov_team_id)).
      or(Team.where(id: rounds.select(:opp_team_id))).
      where.not(id: id)
  end

  def <=>(other)
    if had_rounds? && other.had_rounds?
      return other.stats.wins - stats.wins unless stats.wins == other.stats.wins
      super(other)
    elsif !had_rounds? && !other.had_rounds?
      return seed_int - other.seed_int unless other.seed_int == seed_int
      coin_flip
    else
      raise "Can't compare team with rounds to one without"
    end
  end

  def stats
    @stats ||= Stats::Tournament::TeamPolicy.new(self)
  end

  def had_rounds?
    rounds.any? || gotten_bye?
  end

  def govs
    Round.where(gov_team: self)
  end

  def opps
    Round.where(opp_team: self)
  end

  def hit?(other_team)
    opponents.exists?(id: other_team.id)
  end

  def gotten_bye?
    byes.any?
  end

  def seed_int
    Team.seeds[seed]
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

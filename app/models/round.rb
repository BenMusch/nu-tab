# frozen_string_literal: true

# == Schema Information
#
# Table name: rounds
#
#  id           :integer          not null, primary key
#  result       :integer
#  room_id      :integer
#  gov_team_id  :integer
#  opp_team_id  :integer
#  round_number :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Round < ApplicationRecord
  include CheckInnable

  belongs_to :room
  belongs_to :gov_team, class_name: 'Team'
  belongs_to :opp_team, class_name: 'Team'
  has_many :debater_round_stats
  has_many :debaters, through: :debater_round_stats

  enum result: [:gov_win, :opp_win, :gov_forfeit, :opp_forfeit, :all_drop, :all_win]

  validates :gov_team, presence: true
  validates :opp_team, presence: true
  validates :room, uniqueness: { scope: :round_number },
                   presence:   true
  validates :round_number, presence: true

  validate do
    validate_teams
    validate_standard_result     if full_round?
    validate_non_standard_result if forfeit? || all_drop? || all_win?
  end

  def all_stats_submitted?
    debater_round_stats.count == 4
  end

  def full_round?
    gov_win? || opp_win?
  end

  def forfeit?
    gov_forfeit? || opp_forfeit?
  end

  def winning_team_stats
    gov_win? ? gov_team_stats : opp_team_stats
  end

  def losing_team_stats
    gov_win? ? opp_team_stats : gov_team_stats
  end

  def opp_team_stats
    TeamRoundStats.new debater_round_stats.lo.first, debater_round_stats.mo.first
  end

  def gov_team_stats
    TeamRoundStats.new debater_round_stats.pm.first, debater_round_stats.mg.first
  end

  private

  def validate_teams
    return unless gov_team && opp_team
    errors.add(:base, 'Gov and Opp must be different teams') if gov_team == opp_team
    validate_not_paired_in gov_team
    validate_not_paired_in opp_team
  end

  def validate_not_paired_in(team)
    return unless team.rounds.where(round_number: round_number).where.not(id: id).any?
    field = gov_team == team ? :gov_team : :opp_team
    errors.add(field, 'is already paired in this round')
  end

  def validate_standard_result
    if all_stats_submitted?
      errors.add(:base, 'Ranks are invalid')             unless valid_ranks?
      errors.add(:base, 'Speaks are invalid')            unless valid_speaks?
      errors.add(:base, 'Speaks/Ranks are out of order') unless valid_speaks_ranks_order?
    else
      errors.add(:base, 'Not all speaker positions have been entered')
    end
  end

  def validate_non_standard_result
    return if debater_round_stats.none?
    errors.add(:base, "Can't enter stats for a result other than a gov/opp win")
  end

  def valid_ranks?
    winning_team_stats.ranks <= losing_team_stats.ranks
  end

  def valid_speaks?
    winning_team_stats.speaks >= losing_team_stats.speaks
  end

  def valid_speaks_ranks_order?
    speaks = debater_round_stats.order(ranks: :desc).pluck(:speaks)
    speaks.sort == speaks
  end
end

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
    validate_teams               if gov_team && opp_team
    validate_standard_result     if standard_result?
    validate_non_standard_result if forfeit? || all_drop? || all_win?
  end

  def bye?
    false
  end

  def standard_result?
    gov_win? || opp_win?
  end

  def winner?(team)
    return true if all_win?
    if team == gov_team
      gov_win? || opp_forfeit?
    elsif team == opp_team
      opp_win? || gov_forfeit?
    end
  end

  def forfeit?
    gov_forfeit? || opp_forfeit?
  end

  def opp_stats
    Stats::Round::TeamPolicy.new opp_team, self
  end

  def gov_stats
    Stats::Round::TeamPolicy.new gov_team, self
  end

  def iron_person?(debater)
    debater_round_stats.where(debater: debater).size == 2
  end

  def didnt_compete?(debater)
    debater_round_stats.where(debater: debater).size == 0
  end

  def teams
    [gov_team, opp_team]
  end

  private

  def validate_teams
    errors.add(:base, 'Gov and Opp must be different teams') if gov_team == opp_team
    validate_not_paired_in gov_team
    validate_not_paired_in opp_team
  end

  # rubocop:disable Metrics/AbcSize
  def validate_not_paired_in(team)
    rounds = team.rounds.where(round_number: round_number).where.not(id: id)
    byes = team.byes.where(round_number: round_number)
    return unless rounds.any? || byes.any?

    field = gov_team == team ? :gov_team : :opp_team
    errors.add(field, 'is already paired in this round')
  end
  # rubocop:enable Metrics/AbcSize

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
    winner_stats.ranks <= loser_stats.ranks
  end

  def valid_speaks?
    winner_stats.speaks >= loser_stats.speaks
  end

  def valid_speaks_ranks_order?
    speaks = debater_round_stats.order(ranks: :desc).pluck(:speaks)
    speaks.sort == speaks
  end

  def winner_stats
    return nil if all_drop? || all_win?
    winner?(gov_team) ? gov_stats : opp_stats
  end

  def loser_stats
    return nil if all_drop? || all_win?
    winner?(opp_team) ? gov_stats : opp_stats
  end

  def all_stats_submitted?
    debater_round_stats.count == 4
  end
end

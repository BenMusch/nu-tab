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

  validates :gov_team, uniqueness: { scope: round_number }
  validates :opp_team, uniqueness: { scope: round_number }
  validates :room, uniqueness: { scope: round_number }

  validate do
    if full_round?
      check_complete_result
      check_valid_result
      check_speaks_ranks_order
    end
  end

  def all_stats_submitted?
    debater_round_stats.count == 4
  end

  def full_round?
    result && (gov_win? || opp_win?)
  end

  def valid_ranks?
    winning_team_stats.ranks >= losing_team_stats.ranks
  end

  def valid_speaks?
    losing_team_stats.speaks >= winning_team_stats.ranks
  end

  def winning_team_stats
    gov_win? ? gov_team_stats : opp_team_stats
  end

  def losing_team_stats
    gov_win? ? opp_team_stats : gov_team_stats
  end

  def opp_team_stats
    TeamRoundStats.new [debater_round_stats.lo, debater_round_stats.mg].flatten
  end

  def gov_team_stats
    TeamRoundSats.new [debater_round_stats.pm, debater_round_stats.mg].flatten
  end

  private

  def check_complete_result
    unless all_stats_submitted?
      errors.add('Not all speaker positions have been entered')
    end
  end

  def check_valid_result
    errors.add('Ranks are invalid') unless valid_ranks?
    errors.add('Speaks are invalid') unless valid_speaks?
  end

  def check_speaks_ranks_order
    if debater_round_stats.order(:ranks, :debater_id) !=
        debater_round_stats.order(:ranks, :debater_id)
      errors.add('Speaks/Ranks are mis-matched')
    end
  end
end

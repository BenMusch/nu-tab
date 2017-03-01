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

  validates :gov_team, uniqueness: { scope: :round_number }
  validates :opp_team, uniqueness: { scope: :round_number }
  validates :room, uniqueness: { scope: :round_number }

  validate do
    if full_round?
      if all_stats_submitted?
        check_valid_result
        check_speaks_ranks_order
      else
        errors.add(:base, 'Not all speaker positions have been entered')
      end
    end
  end

  def all_stats_submitted?
    debater_round_stats.count == 4
  end

  def full_round?
    result && (gov_win? || opp_win?)
  end

  def valid_ranks?
    winning_team_stats.ranks <= losing_team_stats.ranks
  end

  def valid_speaks?
    winning_team_stats.speaks >= losing_team_stats.speaks
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

  def check_valid_result
    errors.add(:base, 'Ranks are invalid') unless valid_ranks?
    errors.add(:base, 'Speaks are invalid') unless valid_speaks?
  end

  def check_speaks_ranks_order
    if debater_round_stats.order(:ranks, :debater_id) !=
        debater_round_stats.order(:ranks, :debater_id)
      errors.add(:base, 'Speaks/Ranks are mis-matched')
    end
  end
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: debater_round_stats
#
#  id         :integer          not null, primary key
#  debater_id :integer
#  round_id   :integer
#  speaks     :float
#  ranks      :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DebaterRoundStat < ApplicationRecord
  belongs_to :debater
  belongs_to :round
  enum position: [:pm, :mg, :lo, :mo]

  validates :position, uniqueness: { scope: :round },
                       presence:   true
  validates :ranks, inclusion:  1..4,
                    presence:   true,
                    uniqueness: { scope: :round }
  validates :speaks, inclusion: 22..28,
                     presence:  true

  validate do
    validate_team_membership
  end

  private

  def validate_team_membership
    if team_and_position_mismatch?
      errors.add(:position, "Debater's speaker position does not match their team")
    elsif !(round.opp_team.member?(debater) || round.gov_team.member?(debater))
      errors.add(:debater, 'Debater is not a member of either team in the round')
    end
  end

  def team_and_position_mismatch?
    opposite_team = opp? ? round.gov_team : round.opp_team
    opposite_team.member? debater
  end

  def opp?
    lo? || mo?
  end

  def gov?
    pm? || mg?
  end
end

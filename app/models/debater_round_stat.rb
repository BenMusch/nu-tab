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

  validate :position, uniqueness: { scope:  :round },
                      presence:   true
  validate :ranks, in:       1...4,
                   presence: true
  validate :speaks, in:       TournamentSetting.min_speaks...TournamentSetting.max_speaks,
                    presence: true
end

# frozen_string_literal: true
# == Schema Information
#
# Table name: debater_round_stats
#
#  id         :integer          not null, primary key
#  debater_id :integer
#  round_id   :integer
#  speaker    :float
#  ranks      :integer
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DebaterRoundStat < ApplicationRecord
  belongs_to :debater
  belongs_to :round
  enum position: [:pm, :mg, :lo, :mo]

  validates :position, uniqueness: { scope:  :round },
                       presence:   true
  validates :ranks, inclusion: 1...4,
                    presence:  true
  validates :speaks, inclusion: 22...28,
                     presence:  true
end

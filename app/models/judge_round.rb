# == Schema Information
#
# Table name: judge_rounds
#
#  id         :integer          not null, primary key
#  chair      :boolean
#  round_id   :integer
#  judge_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class JudgeRound < ApplicationRecord
  belongs_to :round
  belongs_to :judge
end

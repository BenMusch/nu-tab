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
  enum result: [:gov_win, :opp_win, :gov_foreit, :opp_forfeit, :all_drop, :all_win, :bye]
end

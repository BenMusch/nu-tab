# frozen_string_literal: true

# Many-to-many relationship between Debaters and Teams
#
# == Schema Information
#
# Table name: debater_teams
#
#  id         :integer          not null, primary key
#  debater_id :integer
#  team_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DebaterTeam < ApplicationRecord
  belongs_to :debater
  belongs_to :team

  validates :team, presence: true
  validates :debater, presence: true,
                      uniqueness: { message: 'Debater cannot be in multiple teams' }

  validate do
    check_team_size
  end

  private

  def check_team_size
    errors.add(:team, 'Team has too many debaters') if team.reload.debaters.size >= 2
  end
end

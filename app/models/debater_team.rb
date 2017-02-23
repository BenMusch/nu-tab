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
end

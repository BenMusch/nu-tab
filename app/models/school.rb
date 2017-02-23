# frozen_string_literal: true

# Represents a School at a tournament
#
# == Schema Information
#
# Table name: schools
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class School < ApplicationRecord
  has_many :debater_teams, through: :debaters
  has_many :teams, through: :debater_teams
  has_many :judges
  has_many :debaters
  has_many :protections
end

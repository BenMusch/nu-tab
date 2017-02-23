# frozen_string_literal: true

# Represents a Team composed of two Debaters
#
# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  seed       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Team < ApplicationRecord
  has_many :protections
  has_many :scratches
  has_many :debater_teams
  has_many :debaters, through: :debater_teams
  has_many :judges, through: :scratches, as: :scratched_judges
  has_many :schools, through: :protections

  enum seed: [:full_seed, :half_seed, :free_seed, :unseeded]
end

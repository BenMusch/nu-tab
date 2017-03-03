# frozen_string_literal: true

# Represents the judges at the tournament
#
# == Schema Information
#
# Table name: judges
#
#  id         :integer          not null, primary key
#  name       :string
#  rank       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Judge < ApplicationRecord
  include CheckInnable

  has_many :scratches
  has_many :teams, through: :scratches, as: :scratched_teams
  has_many :judge_schools
  has_many :schools, through: :judge_schools

  validates :rank, presence:  true,
                   inclusion: 0...100
  validates :name, presence:   true,
                   uniqueness: true,
                   length:     { in: 4...50 }
end

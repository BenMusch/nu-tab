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
  has_many :debaters
  has_many :judge_schools
  has_many :teams, through: :debaters
  has_many :judges, through: :judge_schools
  has_many :debaters

  validates :name, uniqueness: true,
                   presence:   true,
                   length:     { maximum: 20 }

  def teams
    super.uniq
  end
end

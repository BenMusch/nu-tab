# frozen_string_literal: true
class Protection < ApplicationRecord
  belongs_to :team
  belongs_to :school
  self.inheritance_column = :type
  # Secondary protection only applies to hybrid teams
  # Primary protects a team from hitting Teams and Judges from a school
  # Secondary just protects a team from having Judges from a school
  self.types = %w(Primary Secondary)
end

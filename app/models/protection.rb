# frozen_string_literal: true

# Stores information about the schools a team is "protected" from hitting or
# being judged by
#
# Uses Single Table Inheritance to delegate between the Protection::Primary and
# Protection::Secondary classes
#
# == Schema Information
#
# Table name: protections
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  school_id  :integer
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Protection < ApplicationRecord
  belongs_to :team
  belongs_to :school
  self.inheritance_column = :type

  def self.types
    %w(Primary Secondary)
  end
end

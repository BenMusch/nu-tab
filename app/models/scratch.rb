# frozen_string_literal: true

# Represents a scratched judge by a team
#
# == Schema Information
#
# Table name: scratches
#
#  id           :integer          not null, primary key
#  team_id      :integer
#  judge_id     :integer
#  scratch_type :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Scratch < ApplicationRecord
  belongs_to :team
  belongs_to :judge

  enum scratch_type: [:discretionary, :tab]

  validates_uniqueness_of :judge_id, scope: :team_id
end

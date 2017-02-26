# frozen_string_literal: true

# Represents a scratched judge by a team
#
# == Schema Information
#
# Table name: scratches
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  judge_id   :integer
#  type       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Scratch < ApplicationRecord
  belongs_to :team
  belongs_to :judge

  enum type: [:discretionary, :tab]
end

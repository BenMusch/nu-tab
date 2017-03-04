# == Schema Information
#
# Table name: byes
#
#  id           :integer          not null, primary key
#  team_id      :integer
#  round_number :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Bye < ApplicationRecord
  belongs_to :team
end

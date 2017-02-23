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

require 'rails_helper'

RSpec.describe DebaterTeam, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

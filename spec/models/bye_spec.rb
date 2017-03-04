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

require 'rails_helper'

RSpec.describe Bye, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

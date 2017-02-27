# frozen_string_literal: true

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

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Scratch, type: :model do
end

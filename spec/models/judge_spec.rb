# frozen_string_literal: true

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

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Judge, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

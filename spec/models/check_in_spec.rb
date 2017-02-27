# == Schema Information
#
# Table name: check_ins
#
#  id                 :integer          not null, primary key
#  round_number       :integer
#  check_innable_type :string
#  check_innable_id   :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe CheckIn, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

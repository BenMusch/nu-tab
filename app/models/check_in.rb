# == Schema Information
#
# Table name: check_ins
#
#  id                    :integer          not null, primary key
#  round_number          :integer
#  check_innable_id_type :string
#  check_innable_id_id   :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class CheckIn < ApplicationRecord
  belongs_to :check_innable, polymorphic: true
end

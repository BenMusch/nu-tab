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

# frozen_string_literal: true
class Protection
  class Primary < ::Protection
  end
end

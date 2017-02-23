# frozen_string_literal: true

# Represents the judges at the tournament
#
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
class Judge < ApplicationRecord
end

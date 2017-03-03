# frozen_string_literal: true

# == Schema Information
#
# Table name: check_ins
#
#  id           :integer          not null, primary key
#  round_number :integer
#  subject_type :string
#  subject_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class CheckIn < ApplicationRecord
  belongs_to :subject, polymorphic: true

  validates :round_number, presence: true
  validates :subject, presence: true
end

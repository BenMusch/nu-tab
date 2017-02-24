# frozen_string_literal: true

# Many-to-many relationship between judges and schools
#
# == Schema Information
#
# Table name: judge_schools
#
#  id         :integer          not null, primary key
#  judge_id   :integer
#  school_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class JudgeSchool < ApplicationRecord
  belongs_to :judge
  belongs_to :school

  validates :judge, presence: true
  validates :school, presence: true
end

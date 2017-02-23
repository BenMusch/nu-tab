# frozen_string_literal: true
class JudgeSchool < ApplicationRecord
  belongs_to :judge
  belongs_to :school
end

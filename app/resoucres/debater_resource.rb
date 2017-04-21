# frozen_string_literal: true
class DebaterResource < JSONAPI::Resource
  attributes :name, :novice
  belongs_to :team
  belongs_to :school
end
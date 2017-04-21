# frozen_string_literal: true
class TeamResource < JSONAPI::Resource
  attributes :name, :seed
  has_many :debaters
  belongs_to :school
end

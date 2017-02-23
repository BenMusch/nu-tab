# frozen_string_literal: true
class Scratch < ApplicationRecord
  belongs_to :team
  belongs_to :judge

  enum type: [:discretionary, :tab]
end

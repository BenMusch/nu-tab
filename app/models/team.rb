# frozen_string_literal: true
class Team < ApplicationRecord
  enum seed: [:full_seed, :half_seed, :free_seed, :unseeded]
end

# frozen_string_literal: true

# Generates the pairings for the current round
module Pairing
  class PairingGenerator
    def initialize(teams, round_number)
      @teams = if round_number == 1
                teams.sort
              else
                teams.sort_by(&:seed)
              end
    end

    def generate
      teams.delete!(bye.try(:team))
    end

    private

    attr_reader :teams, :round_number

    def bye
      @bye ||= ByeGenerator.generate
    end
  end
end

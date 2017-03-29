# frozen_string_literal: true

# Generates the pairings for the given teams
module Pairing
  class PairingGenerator
    def initialize(teams, round_number:, pairing_algorithm: MaximumWeightMatching)
      @round_number = round_number
      @pairing_alg = pairing_algorithm
      @teams = teams
    end

    def generate!
      raw_pairings.map do |pairing|
        gov, opp = assign_sides(pairing)

        Round.new(round_number: round_number, gov_team: gov, opp_team: opp)
      end
    end

    private

    attr_reader :teams, :pairing_alg, :round_number

    def brackets
      @brackets ||= BracketGenerator.new(teams).generate!
    end

    def raw_pairings
      @raw_pairings ||= brackets.map do |bracket|
        pairing_alg.new(bracket).match!
      end.flatten(1)
    end

    # expect an array of 2 teams, returns with the gov team as [gov, opp] based
    # on previous gov/opp counts
    def assign_sides(pairing)
      if pairing[0].govs.count != pairing[1].govs.count
        pairing.sort_by { |team| team.govs.count }
      elsif pairing[0].opps.count != pairing[1].opps.count
        pairing.sort_by { |team| team.opps.count }.reverse
      else
        pairing.shuffle
      end
    end
  end
end

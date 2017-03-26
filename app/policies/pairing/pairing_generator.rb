# frozen_string_literal: true

# Generates the pairings for the current round
module Pairing
  class PairingGenerator
    def initialize(teams, round_number)
      @teams = if round_number == 1
                 teams.sort
               else
                 # sort by seed, then randomly shuffle amongst equal seeds
                 teams.sort do |a, b|
                   return b.seed - a.seed unless a.seed == b.seed
                   rand(2).zero? ? -1 : 1
                 end
               end
    end

    def generate!
      teams.delete!(bye.try(:team))
      raw_pairings.each do |pairing|
        gov, opp = assign_sides(pairing)

        Round.new(round_number: round_number, gov_team: gov, opp_team: opp)
      end
    end

    private

    attr_reader :teams, :round_number

    def bye
      @bye ||= ByeGenerator.new(teams).generate!
    end

    def brackets
      @brackets ||= BracketGenerator.new(teams).generate!
    end

    def raw_pairings
      @raw_pairings ||= brackets.map do |bracket|
        MaximumWeightMatcher.new(bracket).match!
      end.flatten
    end

    # expect an array of 2 teams, returns with the gov team as [gov, opp] based
    # on previous gov/opp counts
    def assign_sides(pairing)
      if pairing[0].govs.count != pairing[1].govs.count
        pairing.sort_by { |team| team.govs.count }
      elsif pairing[0].opps.count != pairing[1].opps.count
        pairing.sort_by { |team| team.opps.count }
      else
        pairing.shuffle
      end
    end
  end
end

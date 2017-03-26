# frozen_string_literal: true

# Uses the graph_matching gem to generate a minimum-weight matching for the
# passed bracket
module Pairing
  class MaximumWeightMatcher
    def initialize(bracket)
      @bracket = bracket
      # store the integer keys for each team because the graph matching library
      # requires consecutive, positive integers for vertices
      @vertex_nums = {}
    end

    # Returns the optimal matching of the teams, where each pairing is an array
    # of the two teams
    def match!
      matching = graph.maximum_weighted_matching(true).to_a
      matching.map { |edge| [vertex_nums.key(edge[0]), vertex_nums.key(edge[1])] }
    end

    private

    attr_reader :bracket, :vertex_nums

    def all_edges
      @all_edges ||= bracket.combination(2).map do |pairing|
        team1 = pairing[0]
        team2 = pairing[1]

        vertex_nums[team1] ||= bracket.find_index(team1) + 1
        vertex_nums[team2] ||= bracket.find_index(team2) + 1

        [vertex_nums[team1], vertex_nums[team2], Pairing::Penalty.calculate(team1, team2, bracket)]
      end
    end

    def graph
      @graph ||= GraphMatching::Graph::WeightedGraph[*all_edges.map(&:to_a)]
    end
  end
end

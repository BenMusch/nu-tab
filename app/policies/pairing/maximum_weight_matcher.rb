# frozen_string_literal: true

# Uses the graph_matching gem to generate a minimum-weight matching for the
# passed bracket
module Pairing
  class MaximumWeightMatcher
    def initialize(bracket)
      @bracket = bracket
    end

    # Returns the optimal matching of the teams, where each pairing is an array
    # of the two teams
    def match!
      graph.maximum_weighted_matching(false)
    end

    private

    attr_reader :bracket

    def all_edges
      @all_edges ||= bracket.combination(2).map do |pairing|
        Edge.new(pairing[0], pairing[1],
                 Pairing::Penalty.calculate(pairing[0], pairing[1], bracket))
      end
    end

    def graph
      @graph ||= GraphMatching::Graph::WeightedGraph[all_edges.map(&:to_a)]
    end

    # Class to represent a weighted edge in the graph, where each team is a
    # vertex
    class Edge
      attr_reader :team1, :team2, :weight

      def initialize(team1, team2, weight)
        @team1  = team1
        @team2  = team2
        @weight = weight
      end

      def to_a
        [team1, team2, weight]
      end

      # rubocop:disable Metrics/AbcSize
      def ==(other)
        return false unless other.class == self.class

        if other.team1 == team1
          other.team2 == team2
        elsif other.team2 == team1
          other.team1 == team2
        else
          false
        end
      end
      # rubocop:enable Metrics/AbcSize
    end
  end
end

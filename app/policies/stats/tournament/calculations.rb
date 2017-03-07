# frozen_string_literal: true
module Stats
  module Tournament
    module Calculations
      def speaks
        sorted_speaks.reduce(:+) || 0
      end

      def ranks
        sorted_ranks.reduce(:+) || 0
      end

      def single_adjusted_speaks
        single_adjust(sorted_speaks).reduce(:+) || 0
      end

      def single_adjusted_ranks
        single_adjust(sorted_ranks).reduce(:+) || 0
      end

      def double_adjusted_speaks
        double_adjust(sorted_speaks).reduce(:+) || 0
      end

      def double_adjusted_ranks
        double_adjust(sorted_ranks).reduce(:+) || 0
      end

      def average_opponent_wins
        opponents.map { |opponent| TeamPolicy.new(opponent).wins }.reduce(:+) /
          opponents.size.to_f
      end

      private

      def single_adjust(scores)
        scores[1..-2] || []
      end

      def double_adjust(scores)
        single_adjust(single_adjust(scores))
      end

      def sorted_speaks
        @sorted_speaks ||= round_stats.map(&:speaks).sort
      end

      def sorted_ranks
        @sorted_ranks ||= round_stats.map(&:ranks).sort
      end
    end
  end
end

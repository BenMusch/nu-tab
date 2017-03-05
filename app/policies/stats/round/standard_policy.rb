# frozen_string_literal: true
module Stats
  module Round
    class StandardPolicy
      def initialize(debater, round)
        @debater = debater
        @round = round
      end

      def speaks
        stats.speaks
      end

      def ranks
        stats.ranks
      end

      private

      attr_reader :debater, :round

      def stats
        @stats ||= debater.debater_round_stats.find_by(round: round)
      end
    end
  end
end

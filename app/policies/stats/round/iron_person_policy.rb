# frozen_string_literal: true
module Stats
  module Round
    class IronPersonPolicy < StandardPolicy
      def speaks
        stats.pluck(:speaks).reduce(:+) / 2.0
      end

      def ranks
        stats.pluck(:ranks).reduce(:+) / 2.0
      end

      private

      def stats
        @stats ||= debater.debater_round_stats.where(round: round)
      end
    end
  end
end

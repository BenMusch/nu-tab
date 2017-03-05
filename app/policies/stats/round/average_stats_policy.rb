# frozen_string_literal: true
module Stats
  module Round
    class AverageStatsPolicy < StandardPolicy
      def speaks
        all_stats.average(:speaks)
      end

      def ranks
        all_stats.average(:ranks)
      end

      private

      def all_stats
        @all_stats ||= if debater.debater_round_stats.any?
                         debater.debater_round_stats
                       else
                         DebaterRoundStat.all
                       end
      end
    end
  end
end

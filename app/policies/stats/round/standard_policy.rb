# frozen_string_literal: true
module Stats
  module Round
    class StandardPolicy
      attr_reader :debater, :round

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

      def ==(other_obj)
        other_obj.class == self.class &&
          debater == other_obj.debater &&
          round == other_obj.round
      end

      protected

      def stats
        @stats ||= debater.debater_round_stats.find_by(round: round)
      end
    end
  end
end

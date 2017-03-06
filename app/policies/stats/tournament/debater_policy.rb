# frozen_string_literal: true
module Stats
  module Tournament
    class DebaterPolicy
      include Calculations

      def initialize(debater)
        @debater = debater
        @rounds = debater.rounds.distinct.to_a + debater.byes.distinct.to_a
      end

      private

      attr_reader :rounds, :debater

      def round_stats
        @round_stats ||= rounds.map { |round| Stats::Round.policy_for(debater, round) }
      end
    end
  end
end

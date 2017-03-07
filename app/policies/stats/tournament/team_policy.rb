# frozen_string_literal: true
module Stats
  module Tournament
    class TeamPolicy
      include Calculations

      def initialize(team)
        @team = team
        @rounds = team.byes.to_a + team.rounds.to_a
      end

      def wins
        round_stats.count(&:win?)
      end

      def losses
        round_stats.size - wins
      end

      private

      attr_reader :rounds, :team

      def opponents
        @opponents ||= team.opponents
      end

      def round_stats
        @round_stats ||= rounds.map { |round| Stats::Round::TeamPolicy.new(team, round) }
      end
    end
  end
end

# frozen_string_literal: true
module Stats
  module Tournament
    class TeamPolicy
      include Calculations

      def initialize(team)
        @team = team
        @rounds = team.byes.to_a + team.rounds.to_a
      end

      private

      attr_reader :rounds, :team

      def round_stats
        @round_stats ||= rounds.map { |round| Stats::Round::TeamPolicy.new(team, round) }
      end
    end
  end
end

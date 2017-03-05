module Stats
  module Tournament
    class TeamPolicy
      def initialize(team)
        @rounds = team.byes.to_a + team.rounds.to_a
      end

      private

      attr_reader :rounds

      def round_stats
        @round_stats ||= rounds.map { |round| Stats::Round::TeamPolicy.new(debater, round) }
      end

      def sorted_speaks
        @all_speaks ||= round_stats.map(&:speaks).sort
      end

      def sorted_ranks
        @all_ranks ||= round_stats.map(&:ranks).sort
      end
    end
  end
end

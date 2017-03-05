module Stats
  module Tournament
    class DebaterPolicy
      def intialize(debater)
        @rounds = debater.rounds.uniq.to_a + debater.byes.uniq.to_a
      end

      private

      attr_reader :rounds

      def round_stats
        @round_stats ||= rounds.map { |round| Stats::Round.policy_for }
      end
    end
  end
end

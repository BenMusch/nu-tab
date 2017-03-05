# frozen_string_literal: true
module Stats
  module Round
    class TeamPolicy
      def initialize(team, round, debater_policy: Stats::Round::StandardPolicy)
        @leader_stats = debater_policy.new team.debaters.first, round
        @member_stats = debater_policy.new team.debaters.last, round
      end

      def speaks
        leader_stats.speaks + member_stats.speaks
      end

      def ranks
        leader_stats.ranks + member_stats.ranks
      end

      private

      attr_reader :leader_stats, :member_stats
    end
  end
end

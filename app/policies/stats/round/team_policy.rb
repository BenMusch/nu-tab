# frozen_string_literal: true
module Stats
  module Round
    class TeamPolicy
      def initialize(team, round)
        leader = team.debaters.first
        member = team.debaters.last
        @leader_stats = Stats::Round.policy_for(leader, round)
        @member_stats = Stats::Round.policy_for(member, round)
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

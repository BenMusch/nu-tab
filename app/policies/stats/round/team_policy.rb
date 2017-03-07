# frozen_string_literal: true
module Stats
  module Round
    class TeamPolicy
      def initialize(team, round)
        @team = team
        @round = round
      end

      def speaks
        leader_stats.speaks + member_stats.speaks
      end

      def ranks
        leader_stats.ranks + member_stats.ranks
      end

      def win?
        round.winner?(team)
      end

      private

      attr_reader :team, :round

      def leader_stats
        @leader_stats ||= Stats::Round.policy_for(leader, round)
      end

      def member_stats
        @member_stats ||= Stats::Round.policy_for(member, round)
      end

      def iron_person
        team.debaters.each do |debater|
          return debater if round.iron_person? debater
        end
        nil
      end

      def member
        @member ||= iron_person || team.debaters.last
      end

      def leader
        @leader ||= iron_person || team.debaters.first
      end
    end
  end
end

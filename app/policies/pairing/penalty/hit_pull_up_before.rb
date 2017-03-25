# frozen_string_literal: true
module Pairing
  module Penalty
    class HitPullUpBefore < Base
      def self.penalty_name
        'hit_pull_up_before_penalty'
      end

      def value
        team_hitting_pull_up.try(:hit_pull_up) ? penalty : 0
      end

      protected

      # returns the team hitting the pull-up. nil if no pull-up
      def team_hitting_pull_up
        return nil if team1.stats.wins == team2.stats.wins
        team1.stats.wins > team2.stats.wins ? team1 : team2
      end
    end
  end
end

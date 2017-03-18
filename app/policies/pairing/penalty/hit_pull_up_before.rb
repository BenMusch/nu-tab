# frozen_string_literal: true
module Pairing
  module Penalty
    class HitPullUpBefore < Base
      def self.penalty_name
        'hit_pull_up_before_penalty'
      end

      def value
        is_pull_up? && hit_pull_up? ? penalty : 0
      end

      protected

      def is_pull_up?
        team1.stats.wins != team2.stats.wins
      end

      def hit_pull_up?
        team1.hit_pull_up || team2.hit_pull_up
      end
    end
  end
end

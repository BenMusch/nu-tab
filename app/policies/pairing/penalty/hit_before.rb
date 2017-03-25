# frozen_string_literal: true
module Pairing
  module Penalty
    class HitBefore < Base
      def self.penalty_name
        'hit_before_penalty'
      end

      def value
        team1.hit?(team2) ? penalty : 0
      end
    end
  end
end

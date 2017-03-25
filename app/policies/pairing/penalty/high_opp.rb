# frozen_string_literal: true

# Penalty for having num_rounds / 2 + 1 opps
module Pairing
  module Penalty
    class HighOpp < SideCount
      def self.penalty_name
        'high_opp_penalty'
      end

      def self.side
        :opp
      end

      protected

      def threshold
        half_of_rounds
      end
    end
  end
end

# frozen_string_literal: true

# Penalty for having num_rounds / 2 + 2 opps
module Pairing
  module Penalty
    class HighGov < SideCount
      def self.penalty_name
        'max_opp_penalty'
      end

      def self.side
        :opp
      end

      protected

      def threshold
        half_of_rounds + 1
      end
    end
  end
end

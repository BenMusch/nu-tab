# frozen_string_literal: true

# Penalty for having num_rounds / 2 + 1 govs
module Pairing
  module Penalty
    class HighGov < SideCount
      def self.penalty_name
        'high_gov_penalty'
      end

      def self.side
        :gov
      end

      protected

      def threshold
        half_of_rounds
      end
    end
  end
end

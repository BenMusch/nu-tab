# frozen_string_literal: true
module Pairing
  module Penalty
    class SameSchool < Base
      def self.penalty_name
        'same_school_penalty'
      end

      def value
        team1.school == team2.school ? penalty : 0
      end
    end
  end
end

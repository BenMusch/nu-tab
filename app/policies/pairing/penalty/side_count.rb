# frozen_string_literal: true

# An abstract class to represent the penalty for a team being assigned to
# gov/opp a certain number of times
module Pairing
  module Penalty
    class SideCount < Base
      def self.side
        raise NoMethodError, 'Sublcasses of Pairing::Penalty::SideCount must define .side'
      end

      def value
        at_threshold? ? penalty : 0
      end

      protected

      def at_threshold?
        side_count(team1) >= threshold && side_count(team2) >= threshold
      end

      def half_of_rounds
        @half_of_rounds ||= TournamentSetting.get('rounds') / 2 + 1
      end

      def side_count(team)
        team.send("#{self.class.side}s").count
      end

      def threshold
        raise NoMethodError, 'Sublcasses of Pairing::Penalty::Sidecount must implement #threshold'
      end
    end
  end
end

# frozen_string_literal: true

# The class heirarchy for imposing penalities on a given pairing. These
# penalties are used to assign the edge weights when constructing a pairing
module Pairing
  module Penalty
    class Base
      attr_reader :team1, :team2

      # The name of the TournamentSetting key that sets the value of the penalty
      # for this class
      def self.penalty_name
        raise NoMethodError, 'all sublasses must implement .penalty_name'
      end

      def initialize(team1, team2, **kwargs)
        @team1 = team1
        @team2 = team2
        post_initialize(**kwargs)
      end

      # Defines the value of the penalty. Should return 0 if the penalty is not
      # applicable between the two teams
      def value
        raise NoMethodError, 'all sublasses must implement #value'
      end

      protected

      def penalty
        TournamentSetting.get(self.class.penalty_name)
      end

      # Called after initialization in all subclasses to allow for additional
      # configuration of a given penalty
      def post_initialize(**kwargs) end
    end
  end
end

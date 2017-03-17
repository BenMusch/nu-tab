# frozen_string_literal: true
module Pairing
  module Penalty
    class Base
      attr_reader :team1, :team2

      def self.penalty_name
        raise NoMethodError, 'all sublasses must implement .penalty_name'
      end

      def initialize(team1, team2, **kwargs)
        @team1 = team1
        @team2 = team2
        post_initialize(**kwargs)
      end

      def value
        raise NoMethodError, 'all sublasses must implement #value'
      end

      protected

      def penalty
        TournamentSetting.get(self.penalty_name)
      end

      def post_initialize(**kwargs) end
    end

    class ImperfectPairingPenalty < Base
      def self.penalty_name
        'imperfect_pairing_penalty'
      end

      def value
        penalty * variance_from_optimal_pairing / 2.0
      end

      protected

      attr_reader :teams_list

      def post_initialize(**kwargs)
        @teams_list = kwargs[:team_list].to_a
      end

      def variance_from_optimal_pairing
        if TournamentSetting.get('current_round') == 1
          seed_variance
        else
          power_pairing_variance
        end
      end

      def seed_variance
        (team1.seed - optimal_opponent(team2).seed).abs +
          (team2.seed - optimal_opponent(team1).seed).abs
      end

      def power_pairing_variance
        (index_of(team1) - index_of(optimal_opponent(team2))).abs +
          (index_of(team2) - index_of(optimal_opponent(team1))).abs
      end

      def index_of(team)
        teams_list.index(team)
      end

      def optimal_opponent(team)
        teams_list[bracket_size - index_of(team) - 1]
      end

      def bracket_size
        @bracket_size ||= teams_list.size
      end
    end
  end
end

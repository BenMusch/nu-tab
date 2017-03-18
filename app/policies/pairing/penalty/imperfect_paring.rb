# frozen_string_literal: true

# The penalty for a team not being paired against the optimal power-paired
# opponent. The penalty is proportional to the avg. number of spots in the
# power-pairing that the actual opponent strays from their ideal opponent.
#
# For example, if the top team in a bracket is paired against the bottom team,
# the penalty is zero, because that is the optimal pairing.
#
# If the 2nd best team is paired against the 4th worst team, then the penalty
# would be 2 * the penalty for an imperfect pairing, because each team should
# have been hitting an oppoenent two spots higher/lower in the pairing
module Pairing
  module Penalty
    class ImperfectPairing < Base
      def self.penalty_name
        'imperfect_pairing_penalty'
      end

      def value
        penalty * variance_from_optimal_pairing / 2.0
      end

      protected

      attr_reader :teams_list

      # This subclass expects a team_list kwarg to be passed to post_initialize.
      # This should be an even number of sorted teams, which is used to determine
      # the placements in the power-pairing
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

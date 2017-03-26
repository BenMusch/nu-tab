# frozen_string_literal: true
module Pairing
  module Penalty
    PENALTY_CLASSES = [HighGov, HighOpp, HitBefore, HitPullUpBefore,
                       ImperfectPairing, MaxOpp, SameSchool, SideCount]

    def self.calculate(team1, team2, teams)
      PENALTY_CLASSES.map { |klass| klass.new(team1, team2, team_list: teams) }.
        reduce(:+)
    end
  end
end

# frozen_string_literal: true
module Stats
  module Round
    def self.policy_for(team, round)
      if round.bye? || round.all_win?
        AverageStatsPolicy
      elsif round.standard_result?
        StandardPolicy
      elsif round.forfeit? || round.all_drop?
        round.winner?(team) ? AverageStatsPolicy : self.forfeit_policy
      end
    end

    def self.forfeit_policy
      TournamentSetting.get_bool('punish_forfeits') ? PunitivePolicy : AverageStatsPolicy
    end
  end
end

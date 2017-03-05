# frozen_string_literal: true
module Stats
  module Round
    def self.policy_for(team, round)
      if round.bye?
        AverageStatsPolicy
      elsif round.standard_result?
        StandardPolicy
      elsif round.forfeit?
        round.winner?(team) ? AverageStatsPolicy : self.forfeit_policy
      elsif round.all_drop?
        self.forfeit_policy
      elsif round.all_win?
        AverageStatsPolicy
      end
    end

    private

    def self.forfeit_policy
      TournamentSetting.get_bool('punish_forfeits') ? PunitivePolicy : AverageStatsPolicy
    end
  end
end

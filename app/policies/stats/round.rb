# frozen_string_literal: true
module Stats
  module Round
    # rubocop:disable Metrics/PerceivedComplexity
    def self.policy_for(debater, round)
      if round.bye? || round.all_win?
        AverageStatsPolicy.new debater, round
      elsif round.forfeit? || round.all_drop?
        klass = round.winner?(debater.team) ? AverageStatsPolicy : self.forfeit_policy
        klass.new debater, round
      elsif round.didnt_compete?(debater)
        self.forfeit_policy.new debater, round
      elsif round.iron_person?(debater)
        IronPersonPolicy.new debater, round
      elsif round.standard_result?
        StandardPolicy.new debater, round
      else
        BlankPolicy.new debater, round
      end
    end
    # rubocop:enable Metrics/PerceivedComplexity

    def self.forfeit_policy
      TournamentSetting.get_bool('punish_forfeits') ? PunitivePolicy : AverageStatsPolicy
    end
  end
end

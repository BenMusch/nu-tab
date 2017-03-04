# frozen_string_literal: true
module Stats
  module Round
    class PunitivePolicy < StandardPolicy
      def speaks
        TournamentSetting.get('min_speaks')
      end

      def ranks
        3.5
      end
    end
  end
end

# frozen_string_literal: true
module Stats
  module Round
    class BlankPolicy < StandardPolicy
      def speaks
        0
      end

      def ranks
        0
      end
    end
  end
end

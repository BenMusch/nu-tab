# frozen_string_literal: true
module Rankable
  RANKING_PRIORITY = %w(speaks
                        ranks
                        single_adjusted_speaks
                        single_adjusted_ranks
                        double_adjusted_speaks
                        double_adjusted_ranks
                        average_opponent_wins).freeze

  def <=>(other)
    RANKING_PRIORITY.each do |attr|
      difference = stats.send(attr) - other.stats.send(attr)
      next if difference.zero?
      return attr.include?('ranks') ? -1 * difference : difference
    end

    rand(2).zero? ? -1 : 1
  end
end

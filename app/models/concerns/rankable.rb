# frozen_string_literal: true
module Rankable
  RANKING_PRIORITY = ['speaks',
                      'ranks',
                      'single_adjusted_speaks',
                      'single_adjusted_ranks',
                      'double_adjusted_speaks',
                      'double_adjusted_ranks',
                      'average_opponent_wins']

  def <=>(obj)
    RANKING_PRIORITY.each do |attr|
      difference = stats.send(attr) - obj.stats.send(attr)
      next if difference == 0
      return attr.include?('ranks') ? -1 * difference : difference
    end

    rand(2) == 0 ? -1 : 1
  end
end

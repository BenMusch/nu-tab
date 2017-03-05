module Stats
  module Tournament
    def speaks
      all_speaks.reduce(:+) || 0
    end

    def ranks
      all_ranks.reduce(:+) || 0
    end

    def single_adjusted_speaks
      single_adjust(all_speaks).reduce(:+) || 0
    end

    def single_adjusted_ranks
      single_adjust(all_ranks).reduce(:+) || 0
    end

    def double_adjusted_speaks
      double_adjust(all_speaks).reduce(:+) || 0
    end

    def double_adjusted_ranks
      double_adjust(all_ranks).reduce(:+) || 0
    end

    def opponent_wins
      # TODO: make the wins per oppenent so we don't punish Byes
      #   - actually maybe extract an opp wins policy so we don't reward
      #   forefeits?
      oppenents.map { |oppenent| oppenent.wins }.reduce(:+)
    end

    private

    def single_adjust(scores)
      scores[1..-2]
    end

    def double_adjust(scores)
      single_adjust(single_adjust(scores))
    end
  end
end

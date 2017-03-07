# frozen_string_literal: true
module RoundsHelper
  # rubocop:disable Metrics/AbcSize
  def create_round_stats(round:, result:)
    return unless [:gov_win, :opp_win].include? result

    gov_positions = [:pm, :mg]
    opp_positions = [:lo, :mo]

    round.gov_team.debaters.each_with_index do |debater, i|
      increase = result == :gov_win ? 1 : 3
      create(:debater_round_stat, round: round, ranks: i + increase,
                                  debater: debater, position: gov_positions.pop)
    end

    round.opp_team.debaters.each_with_index do |debater, i|
      increase = result == :opp_win ? 1 : 3
      create(:debater_round_stat, round: round, ranks: i + increase,
                                  debater: debater, position: opp_positions.pop)
    end
  end
  # rubocop:enable Metrics/AbcSize

  def create_round_list(count, **attributes)
    count.times do |i|
      create(:round, round_number: i + 1, **attributes)
    end
  end
end

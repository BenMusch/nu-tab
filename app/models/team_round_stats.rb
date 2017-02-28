# frozen_string_literal: true
class TeamRoundStats
  def initialize(team_members)
    @team_stats = team_stats
  end

  def speaks
    team_stats.map(&:speaks).reduce(:+)
  end

  def ranks
    team_stats.map(&:ranks).reduce(:+)
  end

  private

  attr_reader :team_members
end

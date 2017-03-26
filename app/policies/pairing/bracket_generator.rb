# frozen_string_literal: true

# Generates brackets of teams with equal wins, with pull-ups if necessary
module Pairing
  class BracketGenerator
    def initialize(teams)
      @teams = teams
    end

    def generate
      balanced_brackets = []
      raw_brackets.each_with_index do |bracket, i|
        unless bracket.size.even?
          next_bracket = raw_brackets[i+1]
          bracket << get_pull_up(next_bracket)
        end
        balanced_brackets << bracket
      end
    end

    private

    attr_reader :teams

    # Teams, grouped by wins. Not adjusted for pull-ups
    def raw_brackets
      @raw_brackets ||= teams.group_by { |team| team.stats.wins }
    end

    # Gets the lowest-ranked team from the bracket that hasn't been the pull up.
    # Returns the lowest-ranked team if all teams have been the pull-up
    # Will mutate the passed bracket to remove the team
    def get_pull_up(bracket)
      bracket.reverse_each { |team| return bracket.delete(team) unless team.been_pull_up }
      bracket.delete(bracket[-1])
    end
  end
end

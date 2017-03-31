# frozen_string_literal: true

# Finds the team to give the bye to, if any
module Pairing
  class ByeGenerator
    def initialize(teams)
      @teams = teams
    end

    def generate!
      Bye.create(round_number: TournamentSetting.get('current_round'), team: team) if team
    end

    private

    def team
      return nil if teams.size.even?
      teams.reverse_each { |team| return team unless team.gotten_bye? }
      teams[-1]
    end

    attr_reader :teams
  end
end

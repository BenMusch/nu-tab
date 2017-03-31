# frozen_string_literal: true
module Pairing
  class JudgePolicy
    def initialize(judge, team)
      @judge = judge
      @team = team
    end

    def conflicted?
      team_conflict? || scratched? || judged_team_before?
    end

    private

    attr_reader :judge, :team

    def team_conflict?
      team_schools = [team.school] + team.debaters.map(&:school)
      JudgeSchool.exists?(judge: judge, school: team_schools)
    end

    def scratched?
      Scratch.exists?(judge: judge, team: team)
    end

    def judged_team_before?
      JudgeRound.exists?(judge: judge, round: team.rounds)
    end
  end
end

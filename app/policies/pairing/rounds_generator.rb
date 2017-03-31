# frozen_string_literal: true
module Pairing
  class RoundsGenerator
    def initialize(round_number)
      @round_number = round_number
    end

    def rounds
      @rounds ||= pairings.sort.each do |round|
        round.round_number = round_number
        round.room = rooms.pop

        judges.each do |judge|
          next if JudgePolicy.new(judge, round.gov_team).conflicted? ||
            JudgePolicy.new(judge, round.opp_team).conflicted?

          round.judges << judges.pop
          break
        end
      end
    end

    def generate!
      ActiveRecord::Base.transaction do
        bye.save!
        rounds.each(&:save!)
      end
    end

    private

    attr_reader :round_number

    def teams_for_pairing
      @teams_for_pairing ||= teams - [bye.try(:team)]
    end

    def bye
      @bye ||= ByeGenerator.new(teams).generate!
    end

    def teams
      @teams ||= Team.checked_in(round_number).to_a.sort
    end

    def rooms
      @rooms ||= Room.checked_in(round_number).order(:rank).to_a
    end

    def judges
      @judges ||= Judge.checked_in(round_number).order(:rank).to_a
    end

    def pairings
      @pairings ||= PairingGenerator.new(teams_for_pairing).generate!.sort
    end
  end
end

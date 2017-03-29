# frozen_string_literal: true
class RoundGenerator
  def initialize(round_number)
    @round_number = round_number
  end

  def generate!
    rounds.each do |round|
      round.room = rooms.unshift

      judges.each do |judge|
        next if JudgePolicy.new(judge, round.gov_team).conflicted? ||
          JudgePolicy.new(judge, round.opp_team).conflicted?

        round.judge_rounds.build(judge: judge)
      end
    end

    ActiveRecord::Base.transaction do
      bye.save!
      rounds.save!
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
    @teams ||= Team.checked_in(round_number).sort
  end

  def rooms
    @rooms ||= Room.checked_in(round_number).order(rank: :desc)
  end

  def judges
    @judges ||= Judge.checked_in(round_number).order(rank: :desc)
  end

  def rounds
    @rounds ||= PairingGenerator.new(teams_for_pairing, round_number).generate!
  end
end

# frozen_string_literal: true
class CreatePairing
  class NotEnoughJudges < StandardError; end
  class NotEnoughRooms < StandardError; end

  def create!
    raise NotEnoughJudges unless enough_judges?
    raise NotEnoughRooms unless enough_rooms?

    Pairing::RoundsGenerator.new(current_round).generate!
    TournamentSetting.set('current_round', current_round + 1)
  end

  private

  def enough_rooms?
    (Team.checked_in(current_round).count / 2) <= Room.checked_in(current_round).count
  end

  def enough_judges?
    (Team.checked_in(current_round).count / 2) <= Judge.checked_in(current_round).count
  end

  def current_round
    TournamentSetting.get('current_round')
  end
end

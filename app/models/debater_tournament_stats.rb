# frozen_string_literal: true
class DebaterTournamentStats
  def initizliaze(debater)
    @debater = debater
  end

  def speaks
 
  end

  def ranks

  end

  private

  def rounds
    debater.where.not(result: nil)
  end

  def normal_rounds
    debater
  end
end

# frozen_string_literal: true
class TeamRoundStats
  def initialize(leader, member)
    @leader = leader
    @member = member
  end

  def speaks
    leader.speaks + member.speaks
  end

  def ranks
    leader.ranks + member.ranks
  end

  private

  attr_reader :leader, :member
end

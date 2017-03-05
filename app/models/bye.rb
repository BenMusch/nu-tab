# frozen_string_literal: true

# == Schema Information
#
# Table name: byes
#
#  id           :integer          not null, primary key
#  team_id      :integer
#  round_number :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Bye < ApplicationRecord
  belongs_to :team

  validates :team, presence: true, uniqueness: { scope: :round_number }

  validate do
    validate_not_paired_in
  end

  def bye?
    true
  end

  def standard_result?
    false
  end

  def winner
    team
  end

  def forfeit?
    false
  end

  def winner?(team)
    team == self.team
  end

  def all_drop?
    false
  end

  def all_win?
    false
  end

  def iron_person?(debater)
    false
  end

  def didnt_compete?(debater)
    true
  end

  private

  def validate_not_paired_in
    return unless team
    rounds = team.rounds.where(round_number: round_number)
    errors.add(:team, 'is already paired in') if rounds.any?
  end
end

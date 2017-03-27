# frozen_string_literal: true
require 'rails_helper'

# Dummy algorithm to pair each team with the team next in the list
class DummyMatching
  attr_reader :teams

  def initialize(teams)
    @teams = teams
  end

  def match!
    pairings = Array.new([])

    teams.each_with_index do |team, i|
      pairings[i / 2] ? pairings[i / 2] << team : pairings[i / 2] = [team]
    end

    pairings
  end
end

RSpec.describe Pairing::PairingGenerator do
  let(:teams)        { create_list(:team_with_debaters, 6) }
  let(:generator)    { Pairing::PairingGenerator.new(teams, pairing_algorithm: DummyMatching) }
  let(:rounds)       { generator.generate! }

  before(:each) do
    # force pairings to be reversed when 'randomized'
    allow(Kernel).to receive(:rand).with(2).and_return(0)
    # puts all teams into 1 bracket
    allow(Pairing::BracketGenerator).to receive(:new).with(teams).
      and_return(double(generate!: [teams]))
  end

  describe '#generate!' do
    it 'returns an array of rounds' do
      expect(rounds.class).to be Array
      rounds.each do |round|
        expect(round.class).to be Round
      end
    end
  end
end

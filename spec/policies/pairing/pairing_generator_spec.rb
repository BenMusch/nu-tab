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
  let(:generator)    { Pairing::PairingGenerator.new(teams, pairing_algorithm: DummyMatching, round_number: 2) }
  let(:rounds)       { generator.generate! }

  before(:each) do
    # puts all teams into 1 bracket
    allow(Pairing::BracketGenerator).to receive(:new).with(teams).
      and_return(double(generate!: [teams]))

    TournamentSetting.set('current_round', 2)
  end

  describe '#generate!' do
    it 'returns an array of rounds' do
      expect(rounds.class).to be Array
      rounds.each do |round|
        expect(round.class).to be Round
      end
    end

    it 'sets the round_number of the rounds to the current round' do
      rounds.each do |round|
        expect(round.round_number).to be 2
      end
    end

    it 'assigns gov/opps to the round to whichever team has the least rounds on that side' do
      # when one team has more govs, the other team is gov
      allow(teams[0]).to receive(:govs) { double(count: 1) }
      allow(teams[1]).to receive(:govs) { double(count: 2) }

      # when teams have same gov count but different opp count, it gives the gov
      # to the team with the most opps
      allow(teams[2]).to receive(:govs) { double(count: 1) }
      allow(teams[3]).to receive(:govs) { double(count: 1) }
      allow(teams[2]).to receive(:opps) { double(count: 0) }
      allow(teams[3]).to receive(:opps) { double(count: 1) }

      expect(rounds[0].gov_team).to eq teams[0]
      expect(rounds[0].opp_team).to eq teams[1]
      expect(rounds[1].gov_team).to eq teams[3]
      expect(rounds[1].opp_team).to eq teams[2]
    end
  end
end

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Pairing::RoundsGenerator do
  let(:teams)     { create_list(:team_with_debaters, 5) }
  let(:judges)    { create_list(:judge, 3) }
  let(:rooms)     { create_list(:room, 3) }
  let(:generator) { described_class.new 2 }

  before(:each) do
    allow(Pairing::ByeGenerator).to receive(:new).
      and_return(double(generate!: Bye.new(team: teams[2], round_number: 2)))

    teams.each { |team| team.check_in_for_round!(2) }
    rooms.each { |room| room.check_in_for_round!(2) }
    judges.each { |judge| judge.check_in_for_round!(2) }

    rooms.each_with_index { |room, i| room.update_column :rank, 10 - i }
    judges.each_with_index { |judge, i| judge.update_column :rank, 10 - i }
  end

  describe '#rounds' do
    let(:rounds) { generator.rounds }

    it 'pairs the top rounds with the top rooms and judges' do
      expect(rounds[0].judges).to eq [judges.first]
      expect(rounds[0].room).to eq rooms.first
      expect(rounds[1].judges).to eq [judges[1]]
      expect(rounds[1].room).to eq rooms[1]
    end

    it 'excludes rooms & judges that arent checked in' do
      rooms.first.check_out_for_round!(2)
      judges.first.check_out_for_round!(2)

      expect(rounds[0].judges).to eq [judges[1]]
      expect(rounds[0].room).to eq rooms[1]
      expect(rounds[1].judges).to eq [judges.last]
      expect(rounds[1].room).to eq rooms.last
    end

    it 'wont pair in the team with the bye' do
      expect(rounds.map(&:teams).flatten.include?(teams[2])).to be false
    end

    it 'wont pair in judges who are scratched from rounds' do
      # TODO: figure out how to get this test to work
    end
  end

  describe '#generate' do
    it 'creates the rounds & byes' do
      expect(Round.where(round_number: 2).count).to eq 0
      expect(Bye.where(round_number: 2).count).to eq 0

      generator.generate!

      expect(Round.where(round_number: 2).count).to eq 2
      expect(Round.where(round_number: 2).all.to_a).
        to match_array(generator.rounds)

      expect(Bye.where(round_number: 2).count).to eq 1
      expect(Bye.where(round_number: 2).first.team).to eq teams[2]
    end
  end
end

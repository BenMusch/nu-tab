# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CreatePairing do
  let(:create_pairing) { CreatePairing.new }
  let(:current_round) { 2 }
  let(:teams)  { create_list(:team_with_debaters, 4)}
  let(:judges) { create_list(:judge, 2) }
  let(:rooms) { create_list(:room, 2) }

  before do
    TournamentSetting.set('current_round', current_round)
    rooms.each { |room| room.check_in_for_round!(current_round) }
    teams.each { |team| team.check_in_for_round!(current_round) }
    judges.each { |judge| judge.check_in_for_round!(current_round) }
  end

  context "when there aren't enough judges" do
    it 'raises NotEnoughJudges' do
      judges.first.check_out_for_round!(current_round)
      expect{ create_pairing.create! }.to raise_error(CreatePairing::NotEnoughJudges)
    end
  end

  context "when there aren't enough rooms" do
    it 'raises NotEnoughRooms' do
      rooms.first.check_out_for_round!(current_round)
      expect{ create_pairing.create! }.to raise_error(CreatePairing::NotEnoughRooms)
    end
  end

  it 'calls RoundsGenerator#generate! for the current round' do
    mock_generator = double
    allow(Pairing::RoundsGenerator).to receive(:new).and_return(mock_generator)
    expect(mock_generator).to receive(:generate!)

    create_pairing.create!
  end

  it 'increments the round' do
    expect(TournamentSetting.get('current_round')).to eq current_round

    create_pairing.create!

    expect(TournamentSetting.get('current_round')).to eq current_round + 1
  end

  it 'sets pairings to unreleased' do
    TournamentSetting.set('pairings_released', 1)

    create_pairing.create!

    expect(TournamentSetting.get('pairings_released')).to eq 0
  end
end

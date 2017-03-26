# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Pairing::BracketGenerator do
  let(:brackets) { described_class.new(teams).generate! }
  let(:teams) { create_list(:team_with_debaters, 10) }

  context 'when grouping by wins results in all even-length brackets' do
    before do
      teams[0..3].each do |team|
        allow(team).to receive_message_chain('stats.wins').and_return(2)
      end

      teams[4..7].each do |team|
        allow(team).to receive_message_chain('stats.wins').and_return(1)
      end

      teams[8..9].each do |team|
        allow(team).to receive_message_chain('stats.wins').and_return(0)
      end
    end

    it 'returns the even-length brackets' do
      expect(brackets).to eq([teams[0..3], teams[4..7], teams[8..9]])
    end
  end

  context 'when grouping by wins results in some odd-length brackets' do
    let(:balanced_brackets) { [teams[0..4] + [pull_up], teams[5..7] - [pull_up], teams[8..9]] }

    before do
      teams[0..4].each do |team|
        allow(team).to receive_message_chain('stats.wins').and_return(2)
      end

      teams[5..7].each do |team|
        allow(team).to receive_message_chain('stats.wins').and_return(1)
      end

      teams[8..9].each do |team|
        allow(team).to receive_message_chain('stats.wins').and_return(0)
      end
    end

    context 'when the bottom-ranked team in the next bracket has not been pulled up' do
      let(:pull_up) { teams[7] }

      before do
        teams.each { |team| allow(team).to receive(:been_pull_up).and_return(false) }
      end

      it 'pulls-up the bottom-ranked team in the next bracket' do
        expect(brackets).to eq balanced_brackets
      end
    end

    context 'when the bottom-ranked team in the next bracket has been pulled up' do
      let(:pull_up) { teams[6] }

      before do
        allow(teams[5]).to receive(:been_pull_up).and_return(true)
        allow(teams[7]).to receive(:been_pull_up).and_return(true)
      end

      it 'pulls-up the lowest-ranked team in the next bracket that has not been pulled up' do
        expect(brackets).to eq balanced_brackets
      end
    end
  end
end

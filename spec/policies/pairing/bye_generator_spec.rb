# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Pairing::ByeGenerator do
  let(:value) { described_class.new(teams).generate! }

  describe '#generate!' do
    context 'with an even number of team' do
      let(:teams) { create_list(:team_with_debaters, 4) }

      it 'returns nil' do
        expect(value).to be nil
      end
    end

    context 'with an odd number of teams' do
      let(:teams) { create_list(:team_with_debaters, 5) }

      context 'when all teams have gotten a bye' do
        before do
          teams.each do |team|
            allow(team).to receive(:gotten_bye?).and_return(true)
          end
        end

        it 'creates a bye for the last team in the list' do
          expect(value.class).to eq Bye
          expect(value.team).to eq teams[-1]
          expect(value.round_number).to eq TournamentSetting.get('current_round')
          expect(value.created_at).to be_present
        end
      end

      context 'when the lowest-ranked team has gotten a bye' do
        before do
          allow(teams[-1]).to receive(:gotten_bye?).and_return(true)
          allow(teams[-2]).to receive(:gotten_bye?).and_return(true)
          allow(teams[-4]).to receive(:gotten_bye?).and_return(true)
        end

        it "creates a bye for the last team in the list that hasn't gotten a bye" do
          expect(value.class).to eq Bye
          expect(value.team).to eq teams[-3]
          expect(value.round_number).to eq TournamentSetting.get('current_round')
          expect(value.created_at).to be_present
        end
      end

      context "when the lowest-ranked team hasn't gotten a bye" do
        before do
          teams.each do |team|
            allow(team).to receive(:gotten_bye?).and_return(false)
          end
        end

        it 'creates a bye for the last team in the list' do
          expect(value.class).to eq Bye
          expect(value.team).to eq teams[-1]
          expect(value.round_number).to eq TournamentSetting.get('current_round')
          expect(value.created_at).to be_present
        end
      end
    end
  end
end

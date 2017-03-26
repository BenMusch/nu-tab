# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Pairing::MaximumWeightMatcher do
  let(:teams)    { create_list(:team_with_debaters, 6) }
  let(:matching) { described_class.new(teams).match! }

  describe '#match!' do
    before do
      # ensure that the default penalty won't end up in the matching
      allow(Pairing::Penalty).to receive(:calculate).and_return(-100000000000)

      # pairings that belong in the matching
      mock_weight(teams[0], teams[1], -1)
      mock_weight(teams[2], teams[5], -3)
      mock_weight(teams[3], teams[4], -5)

      # pairings that don't belong in the matching
      mock_weight(teams[0], teams[2], 0) # max-weight edge, but would cause lower-weight matching

      mock_weight(teams[1], teams[3], -5)
      mock_weight(teams[1], teams[4], -5)
      mock_weight(teams[1], teams[5], -5)

      mock_weight(teams[3], teams[5], -6)
      mock_weight(teams[4], teams[5], -6)

      mock_weight(teams[0], teams[3], -10)
      mock_weight(teams[0], teams[4], -10)
      mock_weight(teams[0], teams[5], -10)
      mock_weight(teams[2], teams[3], -10)
      mock_weight(teams[2], teams[4], -10)
      mock_weight(teams[1], teams[2], -10)
    end

    it 'generates a maximum-weighted matching of teams' do
      expect(matching).to match_array([[teams[0], teams[1]],
                                       [teams[2], teams[5]],
                                       [teams[3], teams[4]]])
    end
  end

  def mock_weight(team1, team2, weight)
    allow(Pairing::Penalty).to receive(:calculate).with(team1, team2, teams).and_return(weight)
    allow(Pairing::Penalty).to receive(:calculate).with(team2, team1, teams).and_return(weight)
  end
end

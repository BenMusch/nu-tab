# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Pairing::Penalty::ImperfectPairing do
  describe '#value' do
    before do
      TournamentSetting.set('imperfect_pairing_penalty', -1)
    end

    context 'rounds 2+' do
      before do
        TournamentSetting.set('current_round', 2)
      end

      it 'returns the penalty for each "slot" that the pairing is shifted from the perfect pairing' do
        teams = create_list(:team_with_debaters, 6)

        # ideal power-pairings
        penalty = described_class.new teams[0], teams[5], team_list: teams
        expect(penalty.value).to be 0.0

        penalty = described_class.new teams[1], teams[4], team_list: teams
        expect(penalty.value).to be 0.0

        penalty = described_class.new teams[2], teams[3], team_list: teams
        expect(penalty.value).to be 0.0

        # shifted by 1
        penalty = described_class.new teams[1], teams[5], team_list: teams
        expect(penalty.value).to be(-1.0)

        # shifted by 2
        penalty = described_class.new teams[2], teams[5], team_list: teams
        expect(penalty.value).to be(-2.0)

        # shifted by 3
        penalty = described_class.new teams[3], teams[5], team_list: teams
        expect(penalty.value).to be(-3.0)

        # shifted by 4
        penalty = described_class.new teams[4], teams[5], team_list: teams
        expect(penalty.value).to be(-4.0)
      end
    end

    context 'round 1' do
      before do
        TournamentSetting.set('current_round', 1)
      end

      it 'returns the penalty for each change in seed that the pairing is shifted from the perfect pairing' do
        full_seed  = create(:team_with_debaters, seed: :full_seed)
        half_seed  = create(:team_with_debaters, seed: :half_seed)
        half_seed2 = create(:team_with_debaters, seed: :half_seed)
        free_seed  = create(:team_with_debaters, seed: :free_seed)
        free_seed2 = create(:team_with_debaters, seed: :free_seed)
        unseeded   = create(:team_with_debaters, seed: :unseeded)

        teams = [full_seed, half_seed, half_seed2, free_seed, free_seed2, unseeded]

        # ideal power-pairings
        penalty = described_class.new teams[0], teams[5], team_list: teams
        expect(penalty.value).to be 0.0

        penalty = described_class.new teams[1], teams[4], team_list: teams
        expect(penalty.value).to be 0.0

        penalty = described_class.new teams[2], teams[3], team_list: teams
        expect(penalty.value).to be 0.0

        # shifted from power-pairing to hit the same seed
        penalty = described_class.new teams[1], teams[3], team_list: teams
        expect(penalty.value).to be 0.0

        penalty = described_class.new teams[2], teams[4], team_list: teams
        expect(penalty.value).to be 0.0

        # shifted by 1
        penalty = described_class.new teams[0], teams[4], team_list: teams
        expect(penalty.value).to be(-1.0)

        penalty = described_class.new teams[0], teams[3], team_list: teams
        expect(penalty.value).to be(-1.0)

        # shifted by 2
        penalty = described_class.new teams[0], teams[2], team_list: teams
        expect(penalty.value).to be(-2.0)

        penalty = described_class.new teams[0], teams[1], team_list: teams
        expect(penalty.value).to be(-2.0)
      end
    end
  end
end

RSpec.describe Pairing::Penalty::HighGov do
  describe '#value' do
    let(:penalty) { described_class.new team1, team2 }
    let(:team1)   { create(:team_with_debaters) }
    let(:team2)   { create(:team_with_debaters) }

    before(:each) do
      TournamentSetting.set('rounds', 5)
      allow(team1).to receive(:govs) { double(count: team1_count) }
      allow(team2).to receive(:govs) { double(count: team2_count) }
    end

    context 'when neither team would be given an (n/2)+2th gov' do
      let(:team1_count) { 2 }
      let(:team2_count) { 2 }

      it 'returns 0' do
        expect(penalty.value).to be 0
      end
    end

    context 'when only 1 team would be given an (n/2)+2th gov' do
      let(:team1_count) { 3 }
      let(:team2_count) { 2 }

      it 'returns 0' do
        expect(penalty.value).to be 0
      end
    end

    context 'when both teams would be given an (n/2)+2th gov' do
      let(:team1_count) { 3 }
      let(:team2_count) { 3 }

      it 'returns 0' do
        expect(penalty.value).to be TournamentSetting.get('high_gov_penalty')
      end
    end
  end
end

RSpec.describe Pairing::Penalty::HighOpp do
  describe '#value' do
    let(:penalty) { described_class.new team1, team2 }
    let(:team1)   { create(:team_with_debaters) }
    let(:team2)   { create(:team_with_debaters) }

    before(:each) do
      TournamentSetting.set('rounds', 5)
      allow(team1).to receive(:opps) { double(count: team1_count) }
      allow(team2).to receive(:opps) { double(count: team2_count) }
    end

    context 'when neither team would be given an (n/2)+2th opp' do
      let(:team1_count) { 2 }
      let(:team2_count) { 2 }

      it 'returns 0' do
        expect(penalty.value).to be 0
      end
    end

    context 'when only 1 team would be given an (n/2)+2th opp' do
      let(:team1_count) { 3 }
      let(:team2_count) { 2 }

      it 'returns 0' do
        expect(penalty.value).to be 0
      end
    end

    context 'when both teams would be given an (n/2)+2th opp' do
      let(:team1_count) { 3 }
      let(:team2_count) { 3 }

      it 'returns 0' do
        expect(penalty.value).to be TournamentSetting.get('high_opp_penalty')
      end
    end
  end
end

RSpec.describe Pairing::Penalty::MaxOpp do
  describe '#value' do
    let(:penalty) { described_class.new team1, team2 }
    let(:team1)   { create(:team_with_debaters) }
    let(:team2)   { create(:team_with_debaters) }

    before(:each) do
      TournamentSetting.set('rounds', 5)
      allow(team1).to receive(:opps) { double(count: team1_count) }
      allow(team2).to receive(:opps) { double(count: team2_count) }
    end

    context 'when neither team would be given an (n/2)+3th opp' do
      let(:team1_count) { 3 }
      let(:team2_count) { 3 }

      it 'returns 0' do
        expect(penalty.value).to be 0
      end
    end

    context 'when only 1 team would be given an (n/2)+3th opp' do
      let(:team1_count) { 4 }
      let(:team2_count) { 3 }

      it 'returns 0' do
        expect(penalty.value).to be 0
      end
    end

    context 'when both teams would be given an (n/2)+3th opp' do
      let(:team1_count) { 4 }
      let(:team2_count) { 4 }

      it 'returns 0' do
        expect(penalty.value).to be TournamentSetting.get('max_opp_penalty')
      end
    end
  end
end

RSpec.describe Pairing::Penalty::HitBefore do
  describe '#value' do
    let(:penalty) { described_class.new team1, team2 }
    let(:team1)   { create(:team_with_debaters) }
    let(:team2)   { create(:team_with_debaters) }

    before do
      allow(team1).to receive(:hit?).and_return(false)
      allow(team1).to receive(:hit?).with(team2).and_return(true)
    end

    context 'with teams that have hit before' do
      it 'returns hit_before_penalty' do
        expect(penalty.value).to be TournamentSetting.get('hit_before_penalty')
      end
    end

    context 'with teams that have not hit before' do
      it 'returns 0' do
        penalty = described_class.new team1, create(:team_with_debaters)
        expect(penalty.value).to be 0
      end
    end
  end
end

RSpec.describe Pairing::Penalty::HitPullUpBefore do
  describe '#value' do
    let(:penalty) { described_class.new team1, team2 }
    let(:team1)   { create(:team_with_debaters) }
    let(:team2)   { create(:team_with_debaters) }

    context 'when a team has hit the pull up before' do
      let(:team1) { create(:team_with_debaters, hit_pull_up: true) }

      context 'when the teams have the same number of wins' do
        it 'returns 0' do
          allow(team1).to receive(:stats) { double(wins: 2) }
          allow(team2).to receive(:stats) { double(wins: 2) }
          expect(penalty.value).to be 0
        end
      end

      context 'when the teams have a different number of wins' do
        context 'when the team that has hit the pull up is hitting the pull up' do
          it 'returns the penalty' do
            allow(team1).to receive(:stats) { double(wins: 2) }
            allow(team2).to receive(:stats) { double(wins: 1) }
            expect(penalty.value).to be TournamentSetting.get('hit_pull_up_before_penalty')
          end
        end

        context "when the team that hasn't hit the pull up is hitting the pull up" do
          it 'returns 0' do
            allow(team1).to receive(:stats) { double(wins: 1) }
            allow(team2).to receive(:stats) { double(wins: 2) }
            expect(penalty.value).to be 0
          end
        end
      end
    end

    context 'with teams that have not hit the pull up before' do
      it 'returns 0' do
        allow(team1).to receive(:stats) { double(wins: 1) }
        allow(team2).to receive(:stats) { double(wins: 2) }
        expect(penalty.value).to be 0

        allow(team1).to receive(:stats) { double(wins: 2) }
        allow(team2).to receive(:stats) { double(wins: 1) }
        expect(penalty.value).to be 0

        allow(team1).to receive(:stats) { double(wins: 2) }
        allow(team2).to receive(:stats) { double(wins: 2) }
        expect(penalty.value).to be 0
      end
    end
  end
end

RSpec.describe Pairing::Penalty::SameSchool do
  describe '#value' do
    let(:penalty) { described_class.new team1, team2 }
    let(:team1)   { create(:team_with_debaters) }

    context 'when the teams are from the same school' do
      let(:team2) { create(:team_with_debaters, school: team1.school) }

      it 'returns the same_school_penalty' do
        expect(penalty.value).to be TournamentSetting.get('same_school_penalty')
      end
    end

    context 'when the teams are not from the same school' do
      let(:team2) { create(:team_with_debaters, school: create(:school)) }

      it 'returns 0' do
        expect(penalty.value).to be 0
      end
    end
  end
end

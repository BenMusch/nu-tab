# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Pairing::JudgePolicy do
  let(:judge)  { create(:judge) }
  let(:team)   { create(:team_with_debaters) }
  let(:policy) { described_class.new(judge, team) }

  before do
    # generate scratches and rounds that shouldn't affect the conflict
    create(:judge_school, judge: judge, school: create(:school))
    create(:scratch, judge: create(:judge), team: team)
    create(:scratch, judge: judge, team: create(:team_with_debaters))
    round = create(:round, gov_team: team, opp_team: create(:team_with_debaters))
    create(:judge_round, judge: create(:judge), round: round)
    create(:judge_round, judge: judge, round: create(:round))
  end

  describe '#conflicted?' do
    context 'when there are no scratches or school conflicts' do
      it 'is false' do
        expect(policy).not_to be_conflicted
      end
    end

    context 'when the judge belongs to the school of the team' do
      before do
        create(:judge_school, judge: judge, school: team.school)
      end

      it 'is true' do
        expect(policy).to be_conflicted
      end
    end

    context 'when the judge belongs to the school of a debater on the team, regardless of the team school' do
      let(:hybrid_school) { create(:school) }

      before do
        team.debaters.last.school = hybrid_school
        team.debaters.last.save!
        team.save!
        create(:judge_school, judge: judge, school: hybrid_school)
      end

      it 'is true' do
        expect(policy).to be_conflicted
      end
    end

    context 'when the judge is scratched by the team' do
      before do
        create(:scratch, judge: judge, team: team)
      end

      it 'is true' do
        expect(policy).to be_conflicted
      end
    end

    context 'when the judge has judged the team before' do
      before do
        round = create(:round, round_number: 2, opp_team: team)
        create(:judge_round, judge: judge, round: round)
      end

      it 'is true' do
        expect(policy).to be_conflicted
      end
    end
  end
end

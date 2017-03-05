# frozen_string_literal: true

# == Schema Information
#
# Table name: check_ins
#
#  id           :integer          not null, primary key
#  round_number :integer
#  subject_type :string
#  subject_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe CheckIn, type: :model do
  context 'validations' do
    let(:check_in) do
      model = [:judge, :team, :room].sample
      factory = model == :team ? :team_with_debaters : model
      build("#{model}_check_in".to_sym, subject: create(factory), round_number: 1)
    end

    before do
      expect(check_in).to be_valid
    end

    describe 'subject' do
      it 'is present' do
        check_in.subject = nil
        expect(check_in).not_to be_valid
      end
    end

    describe 'round_number' do
      it 'is present' do
        check_in.round_number = nil
        expect(check_in).not_to be_valid
      end
    end
  end

  it 'is polymorphic with Judges, Teams and Rooms' do
    judge = create(:judge)
    judge_check_in = create(:judge_check_in, subject: judge)

    expect(judge_check_in.subject).to eq judge
    expect(judge_check_in.subject_id).to eq(judge.id)
    expect(judge_check_in.subject_type).to eq(judge.class.to_s)

    room = create(:room)
    room_check_in = create(:room_check_in, subject: room)

    expect(room_check_in.subject).to eq(room)
    expect(room_check_in.subject_id).to eq(room.id)
    expect(room_check_in.subject_type).to eq(room.class.to_s)

    team = create(:team_with_debaters)
    team_check_in = create(:team_check_in, subject: team)

    expect(team_check_in.subject).to eq team
    expect(team_check_in.subject_id).to eq(team.id)
    expect(team_check_in.subject_type).to eq(team.class.to_s)
  end
end

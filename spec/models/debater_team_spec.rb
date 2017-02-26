# frozen_string_literal: true

# == Schema Information
#
# Table name: debater_teams
#
#  id         :integer          not null, primary key
#  debater_id :integer
#  team_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe DebaterTeam, type: :model do
  let(:team1)     { create(:team) }
  let(:team2)    { create(:team) }
  let(:debater1) { create(:debater, school: school1) }
  let(:debater2) { create(:debater, school: school2) }
  let(:debater3) { create(:debater, school: school1) }
  let(:school1)  { create(:school) }
  let(:school2)  { create(:school) }

  it "doesn't let debaters join 2 teams" do
    create(:debater_team, debater: debater1, team: team1)
    expect(build(:debater_team, debater: debater1, team: team2)).not_to be_valid
  end

  it "doesn't let a team have more than 2 debaters" do
    create(:debater_team, debater: debater1, team: team1)
    create(:debater_team, debater: debater2, team: team1)
    expect(build(:debater_team, debater: debater3, team: team1)).not_to be_valid
  end

  it 'allows hybrids' do
    create(:debater_team, debater: debater1, team: team1)
    expect(build(:debater_team, debater: debater2, team: team1)).to be_valid
  end

  it 'allows same-school teams' do
    create(:debater_team, debater: debater1, team: team1)
    expect(build(:debater_team, debater: debater3, team: team1)).to be_valid
  end
end

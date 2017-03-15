# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Rankable do
  context 'ranking teams' do
    it 'ranks teams in order of wins & then the attributes in RANKING_PRIORITY' do
      team1 = create_with_stats(:team_with_debaters, wins: 1)
      team2 = create_with_stats(:team_with_debaters, speaks: 1)
      team3 = create_with_stats(:team_with_debaters, ranks: 0)
      team4 = create_with_stats(:team_with_debaters, single_adjusted_speaks: 1)
      team5 = create_with_stats(:team_with_debaters, single_adjusted_ranks: 0)
      team6 = create_with_stats(:team_with_debaters, double_adjusted_speaks: 1)
      team7 = create_with_stats(:team_with_debaters, double_adjusted_ranks: 0)
      team8 = create_with_stats(:team_with_debaters, average_opponent_wins: 1)

      ordered = [team1, team2, team3, team4, team5, team6, team7, team8]
      expect(ordered.shuffle.sort).to eq ordered
    end
  end

  context 'rankings debaters' do
    it 'ranks debaters in order of the attributes in RANKING_PRIORITY' do
      debater1 = create_with_stats(:debater, wins: 1)
      debater2 = create_with_stats(:debater, speaks: 1)
      debater3 = create_with_stats(:debater, ranks: 0)
      debater4 = create_with_stats(:debater, single_adjusted_speaks: 1)
      debater5 = create_with_stats(:debater, single_adjusted_ranks: 0)
      debater6 = create_with_stats(:debater, double_adjusted_speaks: 1)
      debater7 = create_with_stats(:debater, double_adjusted_ranks: 0)
      debater8 = create_with_stats(:debater, average_opponent_wins: 1)

      ordered = [debater2, debater3, debater4, debater5, debater6, debater7, debater8, debater1]
      expect(ordered.shuffle.sort).to eq ordered
    end
  end
end

def create_with_stats(model, **stats)
  team = create(model)
  allow(team).to receive(:stats).and_return(stats_double(**stats))
  team
end

def stats_double(wins: 0, speaks: 0, ranks: 1, single_adjusted_speaks: 0,
                 single_adjusted_ranks: 1, double_adjusted_speaks: 0,
                 double_adjusted_ranks: 1, average_opponent_wins: 0)
  double(wins: wins, speaks: speaks, ranks: ranks,
         single_adjusted_speaks: single_adjusted_speaks,
         single_adjusted_ranks: single_adjusted_ranks,
         double_adjusted_speaks: double_adjusted_speaks,
         double_adjusted_ranks: double_adjusted_ranks,
         average_opponent_wins: average_opponent_wins)
end

FactoryGirl.define do
  factory :tournament_setting do
    key 'key'
    value 1
  end

  factory :bye do
    association :team, factory: :team
    round_number 1
  end

  factory :check_in do
    round_number 1
  end

  factory :judge_check_in, parent: :check_in do
    association :subject, factory: :judge
  end

  factory :room_check_in, parent: :check_in do
    association :subject, factory: :room
  end

  factory :team_check_in, parent: :check_in do
    association :subject, factory: :team
  end

  factory :debater_round_stat do
    association :debater, factory: :debater
    round nil
    speaks 25.5
    ranks 1
    position 1
  end

  factory :judge_round do
    chair false
    round nil
    judge nil
  end

  factory :round do
    result nil
    association :room, factory: :room
    association :gov_team, factory: :team_with_debaters
    association :opp_team, factory: :team_with_debaters
    round_number 1
  end

  factory :judge_school do
    judge nil
    school nil
  end

  factory :protection do
    team nil
    school nil
    type ''
  end

  factory :room do
    sequence(:name) { |n| "Room #{n}" }
    sequence(:rank) { rand(99) + 1 }
  end

  factory :scratch do
    association :judge, factory: :school
    association :team, factory: :team
    scratch_type 1
  end

  factory :team do
    sequence(:name) { |n| "Team #{n}" }
    seed 1
    association :school, factory: :school
  end

  factory :team_with_debaters, parent: :team do
    after(:build) do |team|
      team.debaters = build_list(:debater, (2 - team.debaters.size),
                                 team: team, school_id: team.school_id)
    end
  end

  factory :debater do
    sequence(:name) { |n| "Debater #{n}" }
    novice false
    association :school, factory: :school
  end

  factory :judge do
    sequence(:name) { |n| "Judge #{n}" }
    sequence(:rank) { rand(99) + 1 }
  end

  factory :school do
    sequence(:name) { |n| "School #{n}" }
  end
end

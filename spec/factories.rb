FactoryGirl.define do
  factory :pairing do
    gov_team nil
    opp_team nil
    room nil
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
    debater nil
    round nil
    speaker 1.5
    ranks 1
    position 1
  end
  factory :judge_round do
    chair false
    round nil
    judge nil
  end
  factory :round do
    result 1
    room nil
    gov_team nil
    opp_team nil
    round_number 1
  end
  factory :debater_team do
    debater nil
    team nil
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
    sequence(:name) { Faker::Name.unique.name }
    sequence(:rank) { rand(99) + 1 }
  end
  factory :scratch do
    association :judge, factory: :school
    association :team, factory: :team
    type 1
  end
  factory :team do
    sequence(:name) { |n| "Team #{n}" }
    seed 1
  end
  factory :debater do
    sequence(:name) { Faker::Name.unique.name }
    novice false
    association :school, factory: :school
  end
  factory :judge do
    sequence(:name) { Faker::Name.unique.name }
    sequence(:rank) { rand(99) + 1 }
  end
  factory :school do
    sequence(:name) { Faker::University.unique.name[0...10] }
  end
end

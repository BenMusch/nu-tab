FactoryGirl.define do
  factory :pairing do
    gov_team nil
    opp_team nil
    room nil
    round_number 1
  end
  factory :check_in do
    round_number 1
    check_innable_id 1
    check_innable_type "MyString"
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

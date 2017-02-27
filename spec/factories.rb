FactoryGirl.define do
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

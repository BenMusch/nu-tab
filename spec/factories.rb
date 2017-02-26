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
    name 'MyString'
    rank 1
  end
  factory :scratch do
    team nil
    judge nil
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
    name 'MyString'
    rank 1
  end
  factory :school do
    sequence(:name) { Faker::University.unique.name[0...25] }
  end
end

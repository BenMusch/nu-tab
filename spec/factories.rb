FactoryGirl.define do
  factory :room do
    name "MyString"
    rank 1
  end
  factory :scratch do
    team nil
    judge nil
    type 1
  end
  factory :team do
    name "MyString"
    seed 1
  end
  factory :debater do
    name "MyString"
    novice false
    school nil
  end
  factory :judge do
    name "MyString"
    rank 1
  end
  factory :school do
    name "MyString"
  end
end

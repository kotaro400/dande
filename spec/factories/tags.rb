FactoryBot.define do
  factory :tag do
    sequence(:name){|n| "tag_#{n}"}

    trait :rails do
      name {"rails"}
    end
  end
end

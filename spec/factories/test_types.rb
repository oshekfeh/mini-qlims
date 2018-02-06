FactoryGirl.define do
  factory :test_type do
    name { Faker::Lorem.word }
  end
end

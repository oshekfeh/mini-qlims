FactoryGirl.define do
  factory :todo do
    name { Faker::Lorem.word }
  end
end

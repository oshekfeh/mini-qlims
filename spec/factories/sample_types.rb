FactoryGirl.define do
  factory :sample_type do
    name { Faker::Lorem.word }
  end
end

FactoryGirl.define do
  factory :sample_request do
    code { Faker::Lorem.word }
    status { Faker::Lorem.word }
  end
end

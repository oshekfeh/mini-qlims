FactoryGirl.define do
  factory :request do
    code { Faker::Lorem.word }
    status { Faker::Lorem.word }
  end
end

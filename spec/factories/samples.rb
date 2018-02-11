FactoryGirl.define do
  factory :sample do
    name { Faker::Lorem.word }
    qty { Faker::Number.number(5) }
    sample_type { create(:sample_type) }
    test_type { create(:test_type) }
    unit { create(:unit) }
  end
end

require 'rails_helper'

RSpec.describe TestType, type: :model do
  #Association
  it { should have_many(:samples) }
  it { should have_and_belong_to_many(:sample_types) }

  #Validation
  it { should validate_presence_of(:name) }
end

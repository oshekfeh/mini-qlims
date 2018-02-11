require 'rails_helper'

RSpec.describe SampleRequest, type: :model do
  #Association test
  it { should have_many(:samples).dependent(:destroy)}

  #Validation tests
  it { should validate_presence_of(:status) }
end

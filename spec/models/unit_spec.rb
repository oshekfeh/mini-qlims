require 'rails_helper'

RSpec.describe Unit, type: :model do
  #Association
  it { should have_many(:samples) }

  #Validation
  it { should validate_presence_of(:name) }
end

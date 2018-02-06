require 'rails_helper'

RSpec.describe Sample, type: :model do
  #Association test
  it { should belong_to(:request)}
  
end

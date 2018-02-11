require 'rails_helper'

RSpec.describe Sample, type: :model do
  #Association test
  it { should belong_to(:sample_request)}
  it { should belong_to(:sample_type) }
  it { should belong_to(:test_type) }
  it { should belong_to(:unit) }
end

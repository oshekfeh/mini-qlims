class Sample < ApplicationRecord
  belongs_to :sample_request
  belongs_to :test_type
  belongs_to :sample_type
  belongs_to :unit

end

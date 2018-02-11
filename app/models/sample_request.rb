class SampleRequest < ApplicationRecord
  #Association
  has_many :samples, dependent: :destroy

  #Validation
  validates_presence_of :status
end

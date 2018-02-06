class SampleType < ApplicationRecord
  has_many :samples

  #Validations
  validates_presence_of :name
end

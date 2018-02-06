class SampleType < ApplicationRecord
  has_many :samples
  has_and_belongs_to_many :test_types

  #Validations
  validates_presence_of :name
end

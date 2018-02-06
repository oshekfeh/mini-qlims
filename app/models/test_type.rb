class TestType < ApplicationRecord
  has_many :samples
  has_and_belongs_to_many :sample_types

  #validation
  validates_presence_of :name
end

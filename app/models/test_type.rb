class TestType < ApplicationRecord
  has_many :samples

  #validation
  validates_presence_of :name
end

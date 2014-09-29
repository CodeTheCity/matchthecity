class Region < ActiveRecord::Base
  has_many :venues
  has_many :opportunities, :through => :venues
end

class Venue < ActiveRecord::Base
  has_many :opportunities
  belongs_to :region
end

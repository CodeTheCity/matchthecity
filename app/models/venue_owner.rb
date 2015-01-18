class VenueOwner < ActiveRecord::Base
  belongs_to :region
  has_many :venues
end

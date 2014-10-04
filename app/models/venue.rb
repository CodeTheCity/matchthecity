class Venue < ActiveRecord::Base
  has_many :opportunities
  belongs_to :region

  scope :for_region, lambda { |region|
      where("region_id = ?", region.id ) unless region.blank?
    }
end

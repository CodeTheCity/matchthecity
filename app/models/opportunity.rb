class Opportunity < ActiveRecord::Base
    has_and_belongs_to_many :skills
    belongs_to :activity
    belongs_to :sub_activity
    belongs_to :venue
    has_many :effort_ratings
    accepts_nested_attributes_for :effort_ratings

    scope :for_venue, lambda { |venue|
      where("venue_id = ?", venue.id ) unless venue.blank?
    }

    scope :for_region, lambda { |region|
      joins(:venue).
      where("venues.region_id = ?", region.id ) unless region.blank?
    }

    def effort_rating
      average = self.effort_ratings.average(:rating)
      average = 0 if average.nil?
      average
    end
end

class Opportunity < ActiveRecord::Base
    has_and_belongs_to_many :skills
    belongs_to :activity
    belongs_to :sub_activity
    belongs_to :venue

    scope :for_venue, lambda { |venue|
      where("venue_id = ?", venue.id ) unless venue.blank?
    }
end

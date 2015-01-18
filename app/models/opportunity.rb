# == Schema Information
#
# Table name: opportunities
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  category         :string(255)
#  description      :text
#  created_at       :datetime
#  updated_at       :datetime
#  activity_id      :integer
#  sub_activity_id  :integer
#  venue_id         :integer
#  room             :string(255)
#  start_time       :string(255)
#  end_time         :string(255)
#  day_of_week      :string(255)
#  image_url        :string(255)
#  source_reference :string(255)
#  effort_rating    :integer          default(0)
#

class Opportunity < ActiveRecord::Base
    acts_as_taggable
    has_and_belongs_to_many :skills
    belongs_to :activity
    belongs_to :sub_activity
    belongs_to :venue
    belongs_to :organisation
    has_many :effort_ratings, :dependent => :destroy
    accepts_nested_attributes_for :effort_ratings

    scope :for_venue, lambda { |venue|
      where("venue_id = ?", venue.id ) unless venue.blank?
    }

    scope :for_region, lambda { |region|
      joins(:venue).
      where("venues.region_id = ?", region.id ) unless region.blank?
    }

    scope :with_effort_rating, lambda { |rating|
      where("effort_rating = ?", rating) unless rating.nil?
    }
end

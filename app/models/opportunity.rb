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
#  organisation_id  :integer
#  week_day         :integer
#

class Opportunity < ActiveRecord::Base
include Swagger::Blocks

  swagger_schema :Opportunity do
    key :required, [:id, :name]
    property :id do
      key :type, :integer
      key :format, :int64
      key :description, 'unique identifier for the opportunity'
    end
    property :name do
      key :type, :string
      key :description, 'name of the opportunity'
    end
    property :category do
      key :type, :string
      key :description, 'category of the opportunity'
    end
    property :description do
      key :type, :string
      key :description, 'description of the opportunity. This is in HTML formatted text'
    end
    property :activity do
      key :type, :Activity
      key :description, 'Activity type of the opportunity'
    end
    property :sub_activity do
      key :type, :SubActivity
      key :description, 'Sub-activity type of the opportunity'
    end
    property :venue do
      key :type, :Venue
      key :description, 'Venue the opportunity takes places at'
    end
    property :room do
      key :type, :string
      key :description, 'room the opportunity takes place in'
    end
    property :start_time do
      key :type, :string
      key :description, 'start time of the opportunity in format HH:mm'
    end
    property :end_time do
      key :type, :string
      key :description, 'end time of of the opportunity in format HH:mm'
    end
    property :day_of_week do
      key :type, :string
      key :description, 'day of the week the opportunity takes place. [Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday]'
    end
    property :image_url do
      key :type, :string
      key :description, 'URL of an image that represents the opportunity'
    end
    property :effort_rating do
      key :type, :integer
      key :format, :int64
      key :description, 'Effort rating for the opportunity. This is a value of 1 to 5 with 1 being low effort and 5 being high effort. A value of 0 indicates it has not yet been rated.'
      key :minimum, '0'
      key :maximum, '5'
    end
    property :source_reference do
      key :type, :string
      key :description, 'original ID of the opportunity in its source data'
    end
    property :created_at do
      key :type, :datetime
    end
    property :updated_at do
      key :type, :datetime
    end
    property :url do
      key :type, :string
      key :description, 'URL of the opportunity item'
    end
  end

    acts_as_taggable
    has_and_belongs_to_many :skills
    belongs_to :activity
    belongs_to :sub_activity
    belongs_to :venue
    belongs_to :organisation
    has_many :effort_ratings, :dependent => :destroy
    accepts_nested_attributes_for :effort_ratings

    after_validation :create_activity unless @new_activity.blank?

    validates_presence_of :activity, :if => :should_validate_activity?
    validates_presence_of :sub_activity, :if => :should_validate_sub_activity?
    validates :name, presence: true

    attr_accessor :new_activity
    attr_accessor :new_sub_activity

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

    def should_validate_activity?
      new_activity.blank?
    end

    def should_validate_sub_activity?
      new_sub_activity.blank?
    end

    private
    def create_activity
      puts 'create_activity'
      created_activity = Activity.find_by_title(@new_activity)
      if created_activity.nil?
        created_activity = Activity.new(:title => @new_activity)
        created_activity.save
      end
      self.activity = created_activity


    end
end

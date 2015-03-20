# == Schema Information
#
# Table name: venues
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  address          :string(255)
#  postcode         :string(255)
#  latitude         :string(255)
#  longitude        :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  email            :string(255)
#  telephone        :string(255)
#  web              :string(255)
#  region_id        :integer
#  source_reference :string(255)
#  logo_url         :string(255)
#  venue_owner_id   :integer
#  slug             :string(255)
#

class Venue < ActiveRecord::Base
  include Swagger::Blocks

  swagger_model :Venue do
    key :id, :Venue
    key :required, [:id, :name]
    property :id do
      key :type, :integer
      key :format, :int64
      key :description, 'unique identifier for the venue'
      key :minimum, '0.0'
      key :maximum, '100.0'
    end
    property :name do
      key :type, :string
      key :description, 'name of the venue'
    end
    property :slug do
      key :type, :string
      key :description, 'unique name that identifies the venue and can be used when querying the venues'
      key :required, true
    end
    property :address do
      key :type, :string
      key :description, 'address of the venue'
    end
    property :postcode do
      key :type, :string
      key :description, 'postcode of the venue'
    end
    property :latitude do
      key :type, :double
      key :description, 'latitude of the venue'
    end
    property :longitude do
      key :type, :double
      key :description, 'longitude of the venue'
    end
    property :web do
      key :type, :string
      key :description, 'web address of the venue'
    end
    property :telephone do
      key :type, :string
      key :description, 'telephone number of the venue'
    end
    property :email do
      key :type, :string
      key :description, 'email address of the venue'
    end
    property :region do
      key :type, :Region
      key :description, 'Region the venue belongs to'
    end
    property :venue_owner do
      key :type, :VenueOwner
      key :description, 'Owner of the venue'
    end
    property :venue_notices do
      key :type, :array
      key :description, 'array of notices, such as closures, for the venue'
    end
    property :source_reference do
      key :type, :string
      key :description, 'original ID of the venue in its source data'
    end
    property :created_at do
      key :type, :datetime
    end
    property :updated_at do
      key :type, :datetime
    end
    property :url do
      key :type, :string
      key :description, 'URL of the venue item'
    end
  end

  has_many :opportunities
  belongs_to :region
  belongs_to :venue_owner
  has_many :venue_notices
  before_validation :generate_slug

  validates :slug, uniqueness: true, presence: true

  scope :for_region, lambda { |regionId|
      where("region_id = ?", regionId ) unless regionId.blank?
    }

  scope :for_venue_owner, lambda { |venue_owner |
    where("venue_owner_id = ?", venue_owner.id) unless venue_owner.blank?
  }

  def to_param
    slug
  end

  def generate_slug
    self.slug = name.parameterize unless name.nil?
  end
end

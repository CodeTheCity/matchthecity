# == Schema Information
#
# Table name: venue_owners
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address    :string(255)
#  postcode   :string(255)
#  latitude   :string(255)
#  longitude  :string(255)
#  email      :string(255)
#  telephone  :string(255)
#  web        :string(255)
#  region_id  :integer
#  logo_url   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#

class VenueOwner < ActiveRecord::Base
  include Swagger::Blocks

  swagger_model :VenueOwner do
    key :id, :VenueOwner
    key :required, [:id, :name]
    property :id do
      key :type, :integer
      key :format, :int64
      key :description, 'unique identifier for the venue owner'
    end
    property :name do
      key :type, :string
      key :description, 'name of the venue owner'
    end
    property :slug do
      key :type, :string
      key :description, 'unique name that identifies the venue owner and can be used when querying the venue owners'
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
    property :logo_url do
      key :type, :string
      key :description, 'URL of the logo of the venue owner'
    end
    property :created_at do
      key :type, :datetime
    end
    property :updated_at do
      key :type, :datetime
    end
    property :url do
      key :type, :string
      key :description, 'URL of the venue owner item'
    end
  end

  belongs_to :region
  has_many :venues
  before_validation :generate_slug

  validates :slug, uniqueness: true, presence: true
  validates :region, presence: true

  def to_param
    slug
  end

  def generate_slug
    self.slug = name.parameterize unless name.nil?
  end
end

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
#

class Venue < ActiveRecord::Base
  has_many :opportunities
  belongs_to :region
  belongs_to :venue_owner
  has_many :venue_notices
  before_validation :generate_slug

  validates :slug, uniqueness: true, presence: true

  scope :for_region, lambda { |region|
      where("region_id = ?", region.id ) unless region.blank?
    }

  def to_param
    slug
  end

  def generate_slug
    self.slug = name.parameterize unless name.nil?
  end
end

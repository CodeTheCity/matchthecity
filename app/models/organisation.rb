class Organisation < ActiveRecord::Base
  belongs_to :region
  has_many :opportuntities
end

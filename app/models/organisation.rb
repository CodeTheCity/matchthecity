class Organisation < ActiveRecord::Base
  belongs_to :region
  has_many :opportuntities
  has_and_belongs_to_many :users
end

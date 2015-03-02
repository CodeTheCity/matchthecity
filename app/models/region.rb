# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Region < ActiveRecord::Base
 include Swagger::Blocks

  swagger_model :Region do
    key :id, :Region
    key :required, [:id, :name]
    property :id do
      key :type, :integer
      key :format, :int64
      key :description, 'unique identifier for the region'
      key :minimum, '0.0'
      key :maximum, '100.0'
    end
    property :name do
      key :type, :string
    end
  end


  has_many :venues
  has_many :opportunities, :through => :venues
end

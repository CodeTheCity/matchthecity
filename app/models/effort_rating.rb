# == Schema Information
#
# Table name: effort_ratings
#
#  id             :integer          not null, primary key
#  rating         :integer
#  opportunity_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class EffortRating < ActiveRecord::Base
  include Swagger::Blocks

  swagger_schema :EffortRating do
    key :required, [:id, :opportunity_id]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :opportunity_id do
      key :type, :integer
      key :format, :int64
    end
    property :rating do
      key :type, :integer
      key :format, :int64
    end
  end

  swagger_schema :EffortRatingInput do
    allOf do
      schema do
        key :'$ref', :EffortRating
      end
      schema do
        key :required, [:rating]
        property :id do
          key :type, :integer
          key :format, :int64
        end
      end
    end
  end

  belongs_to :opportunity
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :opportunity, presence: true

end

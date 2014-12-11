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
  belongs_to :opportunity
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end

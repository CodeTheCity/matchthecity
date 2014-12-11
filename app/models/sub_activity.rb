# == Schema Information
#
# Table name: sub_activities
#
#  id          :integer          not null, primary key
#  activity_id :integer
#  title       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class SubActivity < ActiveRecord::Base
  belongs_to :activity
  has_many :opportunities
end

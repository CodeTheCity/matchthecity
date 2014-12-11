# == Schema Information
#
# Table name: activities
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  category   :string(255)
#

class Activity < ActiveRecord::Base
  has_many :opportunities
  has_many :sub_activities
end

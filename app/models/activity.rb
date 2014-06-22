class Activity < ActiveRecord::Base
  has_many :opportunities
  has_many :sub_activities
end

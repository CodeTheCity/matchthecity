class SubActivity < ActiveRecord::Base
  belongs_to :activity
  has_many :opportunities
end

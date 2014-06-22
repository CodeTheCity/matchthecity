class SubActivity < ActiveRecord::Base
  belongs_to :activity
  belongs_to :opportunity
end

class Opportunity < ActiveRecord::Base
    has_and_belongs_to_many :skills
    belongs_to :activity
end

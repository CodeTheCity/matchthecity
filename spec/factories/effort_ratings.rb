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

FactoryGirl.define do
  factory :effort_rating do
    rating { 3 }
    association :opportunity, :factory => :opportunity
  end
end

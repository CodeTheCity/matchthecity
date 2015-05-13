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

FactoryGirl.define do
  factory :sub_activity do
    title { Faker::Lorem.word }
    association :activity, :factory => :activity
  end
end
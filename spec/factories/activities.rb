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

FactoryGirl.define do
  factory :activity do
    title { Faker::Lorem.word }
    category { Faker::Lorem.word }
  end
end
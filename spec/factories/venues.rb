# == Schema Information
#
# Table name: venues
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  address          :string(255)
#  postcode         :string(255)
#  latitude         :string(255)
#  longitude        :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  email            :string(255)
#  telephone        :string(255)
#  web              :string(255)
#  region_id        :integer
#  source_reference :string(255)
#  logo_url         :string(255)
#  venue_owner_id   :integer
#  slug             :string(255)
#  description      :text
#

FactoryGirl.define do
  factory :venue do
    name { Faker::Lorem.word }
    association :region, :factory => :region
    association :venue_owner, :factory => :venue_owner
  end
end
# == Schema Information
#
# Table name: venue_owners
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address    :string(255)
#  postcode   :string(255)
#  latitude   :string(255)
#  longitude  :string(255)
#  email      :string(255)
#  telephone  :string(255)
#  web        :string(255)
#  region_id  :integer
#  logo_url   :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#

FactoryGirl.define do
  factory :venue_owner do
    name { Faker::Company.name }
    association :region, :factory => :region
  end
end
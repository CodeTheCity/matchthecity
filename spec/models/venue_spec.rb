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

require 'rails_helper'

describe Venue do
  it 'has a valid factory' do
    expect(build(:venue)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:venue, name:nil)).to_not be_valid
  end

  it 'is invalid without a region' do
    expect(build(:venue, region:nil)).to_not be_valid
  end

  it 'is invalid without a venue_owner' do
    expect(build(:venue, venue_owner:nil)).to_not be_valid
  end
end
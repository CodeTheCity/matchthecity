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

require 'rails_helper'

describe EffortRating do
  it 'has a valid factory' do
    expect(build(:effort_rating)).to be_valid
  end

  it 'is invalid without an opportunity' do
    expect(build(:effort_rating, opportunity:nil)).to_not be_valid
  end
end
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

require 'rails_helper'

describe SubActivity do
  it 'has a valid factory' do
    expect(build(:sub_activity)).to be_valid
  end

  it 'is invalid without a title' do
    expect(build(:sub_activity, title:nil)).to_not be_valid
  end

  it 'is invalid without an activity' do
    expect(build(:sub_activity, activity:nil)).to_not be_valid
  end
end
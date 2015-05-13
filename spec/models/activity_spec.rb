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

require 'rails_helper'

describe Activity do
  it 'has a valid factory' do
    expect(build(:activity)).to be_valid
  end

  it 'is invalid without a title' do
    expect(build(:activity, title:nil)).to_not be_valid
  end
end
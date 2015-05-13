# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe Region do
  it 'has a valid factory' do
    expect(build(:region)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:region, name:nil)).to_not be_valid
  end
end

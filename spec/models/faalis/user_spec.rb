require 'spec_helper'

RSpec.describe Faalis::User, :type => :model do
  it 'has a valid factory' do
    password = Faker::Internet.password(8)
    expect(build(:faalis_user, password: password)).to be_valid
  end

  it 'should not be valid without a password' do
    expect(build(:faalis_user)).not_to be_valid
  end

  it 'should not be valid without of a valid email' do
    expect(build(:faalis_user, email: '')).not_to be_valid
    expect(build(:faalis_user, email: 'some_email')).not_to be_valid
  end

  it 'should be in "Guest" group if no group provided' do
    user = build(:faalis_user)
    expect(user.groups.size).to eq(1)
    expect(user.groups.first).to be_a_kind_of(Faalis::Group)
  end

end

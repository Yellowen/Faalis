require 'spec_helper'

RSpec.describe Faalis::User, :type => :model do
  it 'has a valid factory' do
    password = Faker::Internet.password(8)
    expect(create(:faalis_user, password: password)).to be_valid
  end

  it 'should not be valid without a password' do
    expect(create(:faalis_user)).to not_valid
  end

end

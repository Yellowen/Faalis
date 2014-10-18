require 'spec_helper'

describe Faalis::User, :type => :model do

  let(:fake_passwird) { Faker::Internet.password(8) }
  let(:admin_group) { create(:faalis_group, name: 'Admin', role: 'admin') }
  let(:guest_group) { create(:faalis_group) }

  it 'has a valid factory' do
    expect(build(:faalis_user, password: fake_password)).to be_valid
  end

  it 'should not be valid without a password' do
    expect(build(:faalis_user)).not_to be_valid
  end

  it 'should not be valid without of a valid email' do
    expect(build(:faalis_user, password: fake_password, email: '')).not_to be_valid
    expect(build(:faalis_user,
                 passowrd: password,
                 email: 'some_email')).not_to be_valid
  end

  it 'should be in "Guest" group if no group provided' do
    user = create(:faalis_user, password: fake_password)
    expect(user.groups.size).to eq(1)
    expect(user.groups.first).to be_a_kind_of(Faalis::Group)
  end

  it 'should have a functional many to many to group' do
    user = build(:faalis_user, groups: [admin_group])
    expect(user.groups.size).to eq(1)
    expect(user.groups.first).to be_a_kind_of(Faalis::Group)
  end
end

require 'spec_helper'
require 'cancan/matchers'

describe Faalis::User, :type => :model do

  let(:fake_password) { Faker::Internet.password(8) }
  let!(:admin_group) { create(:faalis_group, name: 'Admin', role: 'admin') }
  let!(:guest_group) { create(:faalis_group) }

  it 'has a valid factory' do
    expect(build(:faalis_user, password: fake_password)).to be_valid
  end

  context 'Validation' do
    it 'should not be valid without a password' do
      expect(build(:faalis_user)).not_to be_valid
    end

    it 'should not be valid without of a valid email' do
      expect(build(:faalis_user, password: fake_password, email: '')).not_to be_valid
      expect(build(:faalis_user,
                   password: fake_password,
                   email: 'some_email')).not_to be_valid
    end
  end

  describe 'Groups' do
    it 'should be in "Guest" group if no group provided' do
      user = create(:faalis_user, password: fake_password)
      #expect(user.groups.size).to eq(1)
      expect(user.groups.first).to be_a_kind_of(Faalis::Group)
    end

    it 'should have a functional many to many to group' do
      user = create(:faalis_user, groups: [admin_group], password: fake_password)
      expect(user.groups.size).to eq(1)
      expect(user.groups.first).to be_a_kind_of(Faalis::Group)
    end

    it 'can be in serveral groups' do
      user1 = create(:faalis_user,
                     groups: [admin_group, guest_group],
                     password: fake_password)

      user2 = create(:faalis_user,
                     password: fake_password)

      user2.groups << admin_group

      expect(user1.groups.size).to eq(2)
      expect(user2.groups.size).to eq(2)

    end

    it 'should not join to `guest` group when using build' do
      user = build(:faalis_user,
                   password: fake_password)
      expect(user.groups.size).to eq(0)

      user.save

      expect(user.groups.size).to eq(1)
    end
  end

  describe 'Permissions' do


    let!(:admin) do
      create(:faalis_user,
             groups: [admin_group],
             password: fake_password)
    end

    let!(:guest) do
      create(:faalis_user,
             groups: [admin_group],
             password: fake_password)
    end

    context 'Admin user' do
      let!(:ability){ Ability.new(admin) }

      it 'can manage all' do
        expect(admin).to can?(:mange, :all)
      end

    end
  end
end

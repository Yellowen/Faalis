require 'spec_helper'

describe Faalis::User do

  let(:fake_password) { Faker::Internet.password(8) }

  context 'Validation' do
    it 'is not valid without a password' do
      expect(build(:user)).not_to be_valid
    end


    it 'is not valid without of a valid email' do
      user1 = build(:user, password: fake_password, email: '')
      user2 = build(:user, password: fake_password, email: 'some_email')

      expect(user1).not_to be_valid
      expect(user2).not_to be_valid
    end
  end

  describe 'Groups & Roles' do

    it 'has a "roles" method which returns an array of its roles.' do
      user = create(:user, password: fake_password)

      expect(user.roles).to be_a_kind_of(Array)
      expect(user.roles).to include('guest')
    end

    it 'is in "Guest" group if no group provided' do
      user = create(:user, password: fake_password)
      expect(user.groups.size).to eq(1)
      #expect(user.groups.first).to be_a_kind_of(Faalis::Group)
    end

    it 'have a functional many to many to group' do
      user = create(:user, groups: [group(:admin)],
                    password: fake_password)

      expect(user.groups.size).to eq(1)
      expect(user.groups.first).to be_a_kind_of(Faalis::Group)
    end

    it 'can be in serveral groups' do
      user1 = create(:user,
                     groups: [group(:admin), group(:guest)],
                     password: fake_password)

      user2 = create(:user,
                     password: fake_password)

      user2.groups << group(:admin)

      expect(user1.groups.size).to eq(2)
      expect(user2.groups.size).to eq(2)

    end

    it 'should not join to `guest` group when using build' do
      user = build(:user,
                   password: fake_password)
      expect(user.groups.size).to eq(0)

      user.save
      expect(user.groups.size).to eq(1)
    end
  end
end

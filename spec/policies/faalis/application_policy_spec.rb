require 'spec_helper'

describe Faalis::ApplicationPolicy do
  subject { Faalis::ApplicationPolicy.new(user, entity) }

  # We use Group as an entity because we don't have
  # too much models
  let(:entity) { group(:admin) }

  context 'for visitors' do
    let(:user) { nil }

    [:index, :show, :update, :create, :destroy].each do |action|
      it "denies access to #{action} on the protected entity" do
        expect(subject.send("#{action}?")).not_to be(true)
      end
    end
  end

  context 'for guest users' do
    let(:user) { create(:user, password: '123123123') }

    [:index, :show, :update, :create, :destroy].each do |action|
      it "denies access to #{action} on the protected entity" do
        expect(subject.send("#{action}?")).not_to be(true)
      end
    end
  end

  context 'for admin users' do
    let(:user) { create(:admin, password: '123123123') }

    [:index, :show, :update, :create, :destroy].each do |action|
      it "denies access to #{action} on the protected entity" do
        expect(subject.send("#{action}?")).to be(true)
      end
    end
  end

end

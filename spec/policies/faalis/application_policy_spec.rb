require 'spec_helper'

describe Faalis::ApplicationPolicy do
  subject { Faalis::ApplicationPolicy.new(user, entity) }

  # We use Group as an entity because we don't have
  # too much models
  let(:entity) { group(:admin) }

  context 'for visitors' do
    let(:user) { nil }

    it { should_not permit(:show) }

    it 'denies access to the protected entity if user not logged in (by default)' do
      a = Faalis::ApplicationPolicy.new(user, entity)
      expect(a.index?).to be_false
      expect(subject).not_to permit(:create)
      expect(subject).not_to permit(:update)
      expect(subject).not_to permit(:destroy)
    end
  end
end

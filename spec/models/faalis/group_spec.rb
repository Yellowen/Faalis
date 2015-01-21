# == Schema Information
#
# Table name: faalis_groups
#
#  id         :integer          not null, primary key
#  name       :string
#  role       :string
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Faalis::Group do

  context 'Validation' do
    it 'would not be valid if group already exists' do
      create(:admin_group)
      group = build(:admin_group)

      expect(group).not_to be_valid
    end

    it 'would not be valid without a name and role name' do
      group1 = build(:admin_group, name: '')
      group2 = build(:admin_group, role: '')

      expect(group1).not_to be_valid
      expect(group2).not_to be_valid
    end
  end
end

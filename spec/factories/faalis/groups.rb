# Read about factories at https://github.com/thoughtbot/factory_girl

def group(role)
  # get existing group or create new one
  Faalis::Group.where(role: role).first || FactoryGirl.create("#{role}_group")
end

FactoryGirl.define do
  factory :guest_group, :class => 'Faalis::Group' do |f|
    name 'Guest'
    role 'guest'
  end

  factory :admin_group, :class => 'Faalis::Group' do
    name 'Admin'
    role 'admin'
  end
end

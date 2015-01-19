# Read about factories at https://github.com/thoughtbot/factory_girl

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

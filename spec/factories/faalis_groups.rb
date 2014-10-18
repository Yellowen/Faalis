# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :faalis_group, :class => 'Faalis::Group' do |f|
    f.name 'Guest'
    f.role 'guest'
  end
end

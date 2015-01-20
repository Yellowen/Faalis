# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, 'class'.to_sym =>  'Faalis::User' do
    first_name Faker::Name.first_name
    last_name  Faker::Name.first_name
    sequence :email do |n|
      "person#{n}@example.com"
    end

    factory :admin do
      groups { [create(:admin_group)] }
    end
  end
end

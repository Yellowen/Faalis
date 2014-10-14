# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :faalis_user, 'class'.to_sym =>  'Faalis::User' do |f|
    password = Faker::Internet.password(8)
     pepper = nil
     cost = 10
     encrypted_password = ::BCrypt::Password.create("#{password}#{pepper}", :cost => cost).to_s

    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.first_name }
    f.email { Faker::Internet.email }
    #f.encrypted_password encrypted_password
  end
end

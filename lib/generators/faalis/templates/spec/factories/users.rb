FactoryGirl.define do
  factory :faalis_user, :class => Faalis::User do
    email "admin@example.com"
    first_name "admin"
    last_name "admin"
    password "123123123"
    password_confirmation "123123123"
    association :group, :factory => :faalis_group, :name => "admin"
  end
end

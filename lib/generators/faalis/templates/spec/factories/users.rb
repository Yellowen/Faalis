FactoryGirl.define do
  factory :redbase_user, :class => RedBase::User do
    email "admin@example.com"
    first_name "admin"
    last_name "admin"
    password "123123123"
    password_confirmation "123123123"
    association :group, :factory => :redbase_group, :name => "admin"
  end
end

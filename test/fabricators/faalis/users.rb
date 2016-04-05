Fabricator :user, class_name: 'Faalis::User' do
  first_name Faker::Name.first_name
  last_name  Faker::Name.first_name
  email { sequence(:email) { |n| "person#{n}@example.com" } }
end

Fabricator :admin, from: :user do
  groups(count: 1){ Fabricate(:admin_group) }
end

Fabricator :guest, from: :user do
  groups(count: 1){ Fabricate(:guest_group) }
end

Fabricator :manager, from: :user do
  groups(count: 1){ Fabricate(:manager_group) }
end

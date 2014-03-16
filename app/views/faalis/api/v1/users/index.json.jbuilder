json.array! @users do |user|
  json.extract! user, :id, :email, :first_name, :last_name, :name
  json.group user.group, :id, :name
end

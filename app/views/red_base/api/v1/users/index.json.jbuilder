json.array! @users do |user|
  json.extract! user
  json.group @user.group, :name,:id
  end
end

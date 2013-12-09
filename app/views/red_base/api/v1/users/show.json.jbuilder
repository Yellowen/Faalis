json.extract! @user, :id, :email, :first_name, :last_name
json.group @user.group.id

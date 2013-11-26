json.array! @groups do |group|
  json.extract! group, :id, :name
  json.permissions group.permissions do |json, permission|
    json.(permission, :string_repr)
  end
end

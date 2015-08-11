json.extract! @group, :id, :name
json.permissions @group.permissions do |json, permission|
  json.name permission.id_repr
  json.string permission.string_repr
end

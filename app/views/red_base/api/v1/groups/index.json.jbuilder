json.array! @groups do |group|
  json.extract! group, :id, :name
  json.array! group.permissions, :to_s
end

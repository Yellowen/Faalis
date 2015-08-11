json.cache! ['v1', @groups], expires_in: 1.days do
  json.array! @groups do |group|
    json.extract! group, :id, :name
    json.permissions Hash[group.permissions.group_by(&:model).map { |k, v| [k, v.map(&:permission_type)]}]
  end
end

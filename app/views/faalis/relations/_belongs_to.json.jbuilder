unless object.nil?
  json.set! name do
    fields.each do |f|
      json.set! f, eval("object.#{f}")
    end
  end
else
  json.set! name do
    json.id 0
  end
end

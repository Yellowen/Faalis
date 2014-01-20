json.array! @conversation.values do |messages|
  json.extract! messages, :message
end

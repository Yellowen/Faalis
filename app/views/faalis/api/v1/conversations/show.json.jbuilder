json.extract! @conversations, :id, :subject, :created_at, :updated_at

  json.messages @conversations.messages do |m|
    json.subject m.subject
    json.body m.body
  end

  json.recipients @conversations.recipients do |m|
    json.email m.email
  end

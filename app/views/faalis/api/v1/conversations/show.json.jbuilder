json.extract! @conversations, :id, :subject, :created_at, :updated_at

  json.messages @conversations.messages do |m|
    json.id m.id
    json.subject m.subject
    json.body m.body
    json.created_at m.created_at
    json.updated_at m.updated_at
  end

  json.recipients @conversations.recipients do |m|
    json.email m.email
  end

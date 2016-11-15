module Faalis
  class UserMessage < ActiveRecord::Base
    include ::Faalis::Concerns::Authorizable
    belongs_to :sender, class_name: 'Faalis::User'
    belongs_to :reciever, class_name: 'Faalis::User'
  end
end

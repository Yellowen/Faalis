module Faalis
  class UserMessage < ActiveRecord::Base
    belongs_to :sender, class_name: 'Faalis::User'
    belongs_to :reciever, class_name: 'Faalis::User'
  end
end

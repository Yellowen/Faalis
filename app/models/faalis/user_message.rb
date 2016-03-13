module Faalis
  class UserMessage < ActiveRecord::Base
    belongs_to :senders, class_name: Faalis::User
    belongs_to :recievers, class_name: Faalis::User
  end
end

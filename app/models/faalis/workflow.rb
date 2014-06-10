module Faalis
  class Workflow < Faalis::ORM.proper_base_class

    if Faalis::ORM.mongoid?
      include Mongoid::Document
      include Mongoid::Timestamps

      field :name, :type => String
    end

  end
end

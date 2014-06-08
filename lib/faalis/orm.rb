module Faalis
  # A very simple class which provide functionalities to work with
  # current orm
  class ORM

    def self.active_record?
      Faalis::Engine.orm.to_s == 'active_record'
    end

    def self.mongoid?
      Faalis::Engine.orm.to_s == 'mongoid'
    end

    # This class method returns the base class of current ORM
    def self.proper_base_class
      return ActiveRecord::Base if active_record?
      return object if mongoid?
    end
  end
end

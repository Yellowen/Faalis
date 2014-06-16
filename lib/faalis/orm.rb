module Faalis
  # A very simple class which provide functionalities to work with
  # current orm
  class ORM

    def self.active_record?
      current == 'active_record'
    end

    def self.mongoid?
      current == 'mongoid'
    end

    # current orm
    def self.current
      Faalis::Engine.orm.to_s
    end

    # This class method returns the base class of current ORM
    def self.proper_base_class
      return ActiveRecord::Base if active_record?
      return Object if mongoid?
    end
  end
end

# Add inline permissions to any active record models. So we can use them
# to authorize user access.


module ActiveRecord
  class Base
    class Permissions

      # Default permission hash
      @@permissions = {
        :read => nil,
        :update => nil,
        :create => nil,
        :destory => nil,
      }

      @@only_owner = false

      # @return an array of strings representation of permissions
      def self.permission_strings(model)
        strings = []
        @@permissions.each do |key, value|
          strings << {
            :name => "#{key}|#{model.model_name}",
            :string => _("can %s %s") % [_(key.to_s), model.model_name.human]
          }

        end
        strings
      end
      def self.possible_permissions
        @@permissions.keys
      end
      # Define permissions using this method
      def self.permissions(*args)

        args.each do |permission|
          if permission.class == Symbol
            if not @@permissions.include? permission
              @@permission[permission] = nil

            elsif permission.class == Hash

              permission.each do |key, value|
                @@permissions[key.to_sym] = value
              end

            end
          end


        end
      end

      # This force user to have access to resources which is his.
      def self.only_his_objects
        @@only_owner = true
      end

      def self.only_his_objects?
        @@only_owner
      end

    end
  end
end

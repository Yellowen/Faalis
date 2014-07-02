module Faalis
  module Concerns
    # Authorizable modules of Faalis which each resource model should
    # includes this concern. Without this concern, models can be authorized
    module Authorizable
      extend ActiveSupport::Concern

      # Class methods which will add to model by including
      # `Faalis::Concerns::Authorizable`
      module ClassMethods
        # Default permission hash
        @@permissions = {
          read: nil,
          update: nil,
          create: nil,
          destroy: nil,
        }

        @@only_owner = false

        # Return an array of strings representation of permissions
        def permission_strings(model)
          strings = []
          model_name = model.to_s
          humanize_name = ActiveModel::Name.new(model).human
          if model.respond_to? :model_name
            model_name = model.model_name
            humanize_name = model_name.human
          end
          @@permissions.each do |key, value|
            strings << {
              name: "#{key}|#{model_name}",
              string: _("can %s %s") % [_(key.to_s), humanize_name]
            }
          end
          strings
        end

        def possible_permissions
          @@permissions.keys
        end

        # Define permissions using this method
        def permissions(*args)

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
        def only_his_objects
          @@only_owner = true
        end

        def only_his_objects?
          @@only_owner
        end

      end
    end
  end
end

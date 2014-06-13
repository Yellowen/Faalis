module Faalis
  module Discovery
    class Permissions

      def self.all_permissions
        @permissions = []

        # Walkthrough all models in application by using
        # model_discovery gem and check for `permission_strings`
        # method in models (If `Faalis::Permissions` included in
        # model it has the permission_strings). And concat the
        # permissions to `@permissions` instance method.
        ::ApplicationModels.each do |m|
          model = m.model.constantize
          puts "<<<<<<<<<<< ", model
          if model.respond_to? :permission_strings
            @permissions.concat(model.permission_strings(model))
          end
        end

        # Check also for entities which don't have a model but
        # we need to use them in our permissions.
        Faalis::Engine.models_with_permission.each do |m|
          model = m.constantize
          if model.respond_to? :permission_strings
            @permissions.concat(model.permission_strings(model))
          end
        end

        @permissions.uniq
      end

      def self.create_all_permissions
        puts ">>>>>>>>>>>> ", all_permissions
      end
    end
  end
end

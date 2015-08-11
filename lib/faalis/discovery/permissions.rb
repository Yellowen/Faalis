module Faalis
  module Discovery
    # This class is responsible to discoering all Permissions
    # classes and provide a list of available permissions
    class Permissions

      # Run the given block for each object with permissions
      def self.permission_objects(&block)
        objects = []

        # Walkthrough all models in application by using
        # model_discovery gem and check for `permission_strings`
        # method in models (If `Faalis::Permissions` included in
        # model it has the permission_strings). And concat the
        # permissions to `@permissions` instance method.
        ::ApplicationModels.to_adapter.find_all.each do |m|
          # `m` is a string contains name of a model and
          # we use contstantize to get the model class with
          # such name
          model = m.model.constantize
          if model.respond_to? :permission_strings
            block.call(model)
          end
        end

        # Check also for entities which don't have a model but
        # we need to use them in our permissions.
        Faalis::Engine.models_with_permission.each do |m|
          model = m.constantize
          if model.respond_to? :permission_strings
            block.call(model)
          end
        end
      end

      def self.all_permissions
        permissions = []
        permission_objects do |object|
          permissions.concat(object.permission_strings(object))
        end

        permissions.uniq
      end

      # Creating all possible permissions in database using
      # `Faalis::Permission` model
      def self.create_all_permissions

        permission_objects do |object|
          object.possible_permissions.each do |perm|
            Faalis::Permission.where(model: object.to_s,
                                     permission_type: perm).first_or_create
          end
        end
      end
    end
  end
end

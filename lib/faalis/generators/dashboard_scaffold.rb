module Faalis
  module Generators
    # `DashboardScaffold` is the base class for all the dashboard
    # scaffolds which make creating scaffold generators way more
    # easier. But you can drive your own generator normally of caurse
    class DashboardScaffold < Rails::Generators::Base

      include ActionView::Helpers::TextHelper
      include Faalis::Generators::Concerns::JsonInput
      include Faalis::Generators::Concerns::ResourceName
      include Faalis::Generators::Concerns::ResourceFields
      include Faalis::Generators::Concerns::Menu
      include Faalis::Generators::Concerns::Dependency
      include Faalis::Generators::Concerns::Bulk
      include Faalis::Generators::Concerns::RequireFields
      include Faalis::Generators::Concerns::Parent
      include Faalis::Generators::Concerns::Angular
      include Faalis::Generators::Concerns::Tabs
      include Faalis::Generators::Concerns::Model


      # Do not install specs
      class_option :without_specs, :type => :boolean, :default => false, :desc => "Do not install specs"

      # Generate only spec files
      class_option :only_specs, :type => :boolean, :default => false, :desc => "Generate only spec files"

      # Generate only controller
      class_option :only_controller, :type => :boolean, :default => false, :desc => "Generate only controller"

      # Don't show a filter box
      class_option :no_filter, :type => :boolean, :default => false, :desc => "Don't view a filter box"


    end
  end
end

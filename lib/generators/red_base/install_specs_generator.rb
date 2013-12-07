# -----------------------------------------------------------------------------
#    Red Base - Basic website skel engine
#    Copyright (C) 2012-2013 Yellowen
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
# -----------------------------------------------------------------------------

module RedBase
  module Generators
    class InstallSpecsGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      desc "Copy all the necessary files to install and use specs"

      def install_gems
        invoke "rspec:install"
        invoke "cucumber:install", ["--capybara", "--rspec"]
      end

      def update_configurations
        copy_file "features/step_definitions/email_steps.rb", "features/step_definitions/email_steps.rb"
        copy_file "features/support/env.rb", "features/support/env.rb"
        copy_file "spec/factories/groups.rb", "spec/factories/groups.rb"
        copy_file "spec/factories/users.rb", "spec/factories/users.rb"
        copy_file "spec/spec_helper.rb", "spec/spec_helper.rb"
        copy_file "spec/support/devise.rb", "spec/support/devise.rb"
      end

      def show_readme
        readme "SPECS" if behavior == :invoke
      end


    end
  end
end

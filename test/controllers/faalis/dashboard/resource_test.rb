require "test_helper"

# Testing dashboard controller routes of a Faalis plugin ----------------------

module Faalis
  module Dashboard
    module SomeEngine
      class PostsController < Faalis::Dashboard::ApplicationController
        engine 'Faalis::Engine'
        route_namespace 'some_engine'

      end
    end
  end
end


class TestPluginDashboardControllers < ActionController::TestCase

  tests Faalis::Dashboard::SomeEngine::PostsController


  def setup
    #@routes = Faalis::Engine.routes
    @routes.draw do
      namespace :faalis do
        namespace :dashboard do
          namespace :some_engine do
            resource :posts
          end
        end
      end
    end
  end

  test 'guess the right `new` route based on controller' do
    get :new
    route = @controller.send(:_new_route)

    assert_equal 'new_dashboard_some_engine_post_path', route
  end

  test 'guess the right `index` route based on controller' do
    get :index
    route = @controller.send(:_index_route)

    assert_equal 'dashboard_some_engine_posts_path', route
  end

  test 'guess the right `show` route based on controller' do
    route = @controller.send(:_show_route)

    assert_equal 'dashboard_some_engine_post_path', route
  end
end

# Testing dashboard controller routes of a normal controller ------------------

module Dashboard
  class PostController < Faalis::Dashboard::ApplicationController
  end
end

class TestDashboardControllers < ActionController::TestCase

  tests Dashboard::PostController

  test 'guess the right `new` route based on controller' do
    route = @controller.send(:_new_route)

    assert_equal 'new_dashboard_post_path', route
  end

  test 'guess the right `index` route based on controller' do
    route = @controller.send(:_index_route)

    assert_equal 'dashboard_posts_path', route
  end

  test 'guess the right `show` route based on controller' do
    route = @controller.send(:_show_route)

    assert_equal 'dashboard_post_path', route
  end
end


# Testing dashboard controller routes of a namespaced controller --------------

module Dashboard
  module SomeModule
    class PostController < Faalis::Dashboard::ApplicationController
    end
  end
end

class TestDashboardNestedControllers < ActionController::TestCase

  tests Dashboard::SomeModule::PostController

  test 'guess the right `new` route based on controller' do
    route = @controller.send(:_new_route)

    assert_equal 'new_dashboard_some_module_post_path', route
  end

  test 'guess the right `index` route based on controller' do
    route = @controller.send(:_index_route)

    assert_equal 'dashboard_some_module_posts_path', route
  end

  test 'guess the right `show` route based on controller' do
    route = @controller.send(:_show_route)

    assert_equal 'dashboard_some_module_post_path', route
  end
end

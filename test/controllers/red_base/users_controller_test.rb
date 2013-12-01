require 'test_helper'

module RedBase
  class UsersControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end

    test "should get show" do
      get :show
      assert_response :success
    end

    test "should get distroy" do
      get :distroy
      assert_response :success
    end

    test "should get edit" do
      get :edit
      assert_response :success
    end

    test "should get create" do
      get :create
      assert_response :success
    end

  end
end

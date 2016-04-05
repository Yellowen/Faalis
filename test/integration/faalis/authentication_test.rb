require "test_helper"

class AuthenticationTest < ActionDispatch::IntegrationTest
  def setup
    @admin = Fabricate(:admin, password: '123123123',
                       password_confirmation: '123123123',
                       email: 'admin@example.com')

    @admin.save
    @guest = Fabricate(:guest, password: '123123123',
                       password_confirmation: '123123123')

  end

  test 'authentication is up and running' do
    visit user_session_path

    assert_text 'Sign In'
    assert_css '.login-box-msg'
    assert_selector '#user_email'
    assert_selector '#user_password'
  end

  test 'authentication allows user to successfully log in using valid credentials' do
    visit dashboard_index_path

    fill_in 'user_email', with: @admin.email
    fill_in 'user_password', with: '123123123'

    click_button 'sign_in'

    assert_text 'Dashboard'
    assert_no_text 'Sign In'
    assert_equal current_path, dashboard_index_path
  end
end

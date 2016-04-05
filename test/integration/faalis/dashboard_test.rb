require "test_helper"

class DashboardTest < ActionDispatch::IntegrationTest

  def setup
    @admin = Fabricate(:admin, password: '123123123',
                       password_confirmation: '123123123')

    @guest = Fabricate(:guest, password: '123123123',
                       password_confirmation: '123123123')
    @faalis = Faalis::Engine.routes.url_helpers
  end

  test "loads normally after login" do
    login_as(@admin, scope: :user)
    path = "/#{Faalis::Engine.dashboard_namespace}"

    visit faalis.dashboard_index_path

    assert_equal page.status_code, 200
    assert_text 'Faalis'
    assert_text 'Dashboard'
    assert_no_text '404'
    assert_no_text 'Oops!'
    assert_equal current_path, path
  end

  test 'does not load with anonymous users' do
    visit @faalis.dashboard_index_path

    assert_equal page.status_code, 200
    assert_equal current_path, @faalis.user_session_path
  end

  test 'does not provide authentication section for guests' do
    visit @faalis.dashboard_index_path

    assert_equal page.status_code, 200
    assert_no_text('User Management')
    assert_no_text('Users')
    assert_no_text('Groups')
  end

  test 'User try to find a resource which does not exists via js format.' do
    login_as(@admin, scope: :user)

    visit @faalis.dashboard_auth_user_path({ id: 3242, format: :js})

    assert_equal page.status_code, 200
    assert_text('error_message(')
  end

  test 'User try to find a valid resource' do
    login_as(@admin, scope: :user)

    visit @faalis.dashboard_auth_user_path({ id: 1 })

    assert_equal page.status_code, 200
    assert_no_text('404')
    assert_text('User')
    assert_no_text('Oops!')
  end

end

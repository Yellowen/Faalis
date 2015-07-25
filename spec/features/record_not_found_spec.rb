require 'spec_helper'

feature 'Dashboard resource finder exception' do
  before do
    @user = create(:user, password: '123123123',
                   password_confirmation: '123123123')
    login_as(@user, scope: :user)
    @faalis = Faalis::Engine.routes.url_helpers
  end

  scenario 'User try to find a resource which does not exists.' do
    visit faalis.dashboard_auth_users_show_url({ id: 3242 })
    expect(page).to have_text('404')
  end

  scenario 'User try to find a resource which does not exists via js format.' do
    visit @faalis.dashboard_auth_users_show_path({ id: 3242, format: :js})
    expect(page).to have_text('error_message(')
  end

  scenario 'User try to find a valid resource' do
    visit @faalis.dashboard_auth_users_show_path({ id: 1 })
    expect(page).not_to have_text('404')
  end

end

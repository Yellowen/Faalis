require 'spec_helper'

feature 'Dashboard section' do
  before do
    @admin = create(:admin, password: '123123123',
                    password_confirmation: '123123123')

    @guest = create(:guest, password: '123123123',
                    password_confirmation: '123123123')
    @faalis = Faalis::Engine.routes.url_helpers
  end

  scenario 'loads normally after logging in.' do
    login_as(@admin, scope: :user)
    path = "/#{Faalis::Engine.dashboard_namespace}"
    visit faalis.dashboard_index_path
    expect(page).not_to have_text('404')
    expect(page).not_to have_text('Oops!')
    expect(page).to have_text('Faalis')
    expect(page).to have_text('Dashboard')
    expect(page).to have_text('Authentication')
    expect(current_path).to eq(path)
  end

  scenario 'does not load with anonymous users' do
    visit @faalis.dashboard_index_path
    expect(current_path).to eq(@faalis.user_session_path)
  end
end

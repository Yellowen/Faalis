require 'spec_helper'

feature 'Sign in page', js: true do
  before do
    @admin = build(:admin, password: '123123123',
                   password_confirmation: '123123123',
                   email: 'admin@example.com')

    @admin.save
    @guest = create(:guest, password: '123123123',
                    password_confirmation: '123123123')
    @faalis = Faalis::Engine.routes.url_helpers
  end

  scenario 'is up and running' do
    visit @faalis.user_session_path

    expect(page).to have_text('Sign In')
    expect(page).to have_css('.login-box-msg')
    expect(page).to have_selector('#user_email')
    expect(page).to have_selector('#user_password')
  end

  scenario 'allow user to successfully log in using valid credentials' do
    visit @faalis.dashboard_index_path

    fill_in 'user_email', with: @admin.email
    fill_in 'user_password', with: '123123123'

    click_button 'sign_in'

    expect(page).to have_text('Dashboard')
    expect(page).not_to have_text('Sign In')
    expect(current_path).to eq(@faalis.dashboard_index_path)

  end
end

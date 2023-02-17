require 'rails_helper'

RSpec.describe 'Logging in with Google OmniAuth using Devise', type: :feature do
  let!(:user) { User.find_or_create_by(email: 'test@example.com') } # assuming you have a user model

  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      {
        provider: 'google_oauth2',
        uid: '123456',
        info: {
          email: user.email,
          first_name: user.name
        },
        credentials: {
          token: 'token',
          refresh_token: 'refresh_token',
          expires_at: Time.current + 1.week
        }
      }
    )
  end

  it 'allows a user to log in with Google OmniAuth' do
    visit new_user_session_path

    click_on 'Sign in'

    expect(page).to have_content('Successfully authenticated from Google account.')
    expect(page).to have_content(user.email)
    expect(page).to have_button('Logout')
  end
end
